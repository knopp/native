// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('mac-os')
@OnPlatform({'mac-os': Timeout.factor(2)})
library;

import 'dart:io';

import 'package:native_toolchain_c/native_toolchain_c.dart';
import 'package:native_toolchain_c/src/utils/run_process.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  if (!Platform.isMacOS) {
    // Avoid needing status files on Dart SDK CI.
    return;
  }

  const targets = [Architecture.arm64, Architecture.x64];

  // Dont include 'mach-o' or 'Mach-O', different spelling is used.
  const objdumpFileFormat = {
    Architecture.arm64: 'arm64',
    Architecture.x64: '64-bit x86-64',
  };

  const optimizationLevels = OptimizationLevel.values;
  var selectOptimizationLevel = 0;

  for (final language in [Language.c, Language.objectiveC]) {
    for (final linkMode in [DynamicLoadingBundled(), StaticLinking()]) {
      for (final target in targets) {
        // Cycle through all optimization levels.
        final optimizationLevel = optimizationLevels[selectOptimizationLevel];
        selectOptimizationLevel =
            (selectOptimizationLevel + 1) % optimizationLevels.length;

        test(
          'CBuilder $linkMode $language library $target $optimizationLevel',
          () async {
            final tempUri = await tempDirForTest();
            final tempUri2 = await tempDirForTest();
            final sourceUri = switch (language) {
              Language.c => packageUri.resolve(
                'test/cbuilder/testfiles/add/src/add.c',
              ),
              Language.objectiveC => packageUri.resolve(
                'test/cbuilder/testfiles/add_objective_c/src/add.m',
              ),
              Language() => throw UnimplementedError(),
            };
            const name = 'add';

            final buildInputBuilder =
                BuildInputBuilder()
                  ..setupShared(
                    packageName: name,
                    packageRoot: tempUri,
                    outputFile: tempUri.resolve('output.json'),
                    outputDirectory: tempUri,
                    outputDirectoryShared: tempUri2,
                  )
                  ..config.setupBuild(linkingEnabled: false)
                  ..addExtension(
                    CodeAssetExtension(
                      targetOS: OS.macOS,
                      targetArchitecture: target,
                      linkModePreference:
                          linkMode == DynamicLoadingBundled()
                              ? LinkModePreference.dynamic
                              : LinkModePreference.static,
                      cCompiler: cCompiler,
                      macOS: MacOSCodeConfig(
                        targetVersion: defaultMacOSVersion,
                      ),
                    ),
                  );
            final buildInput = BuildInput(buildInputBuilder.json);
            final buildOutput = BuildOutputBuilder();

            final cbuilder = CBuilder.library(
              name: name,
              assetName: name,
              sources: [sourceUri.toFilePath()],
              language: language,
              optimizationLevel: optimizationLevel,
              buildMode: BuildMode.release,
            );
            await cbuilder.run(
              input: buildInput,
              output: buildOutput,
              logger: logger,
            );

            final libUri = buildInput.outputDirectory.resolve(
              OS.macOS.libraryFileName(name, linkMode),
            );
            final result = await runProcess(
              executable: Uri.file('objdump'),
              arguments: ['-t', libUri.path],
              logger: logger,
            );
            expect(result.exitCode, 0);
            final machine = result.stdout
                .split('\n')
                .firstWhere((e) => e.contains('file format'));
            expect(machine, contains(objdumpFileFormat[target]));
          },
        );
      }
    }
  }

  const flutterMacOSLowestBestEffort = 12;
  const flutterMacOSLowestSupported = 13;

  for (final macosVersion in [
    flutterMacOSLowestBestEffort,
    flutterMacOSLowestSupported,
  ]) {
    for (final linkMode in [DynamicLoadingBundled(), StaticLinking()]) {
      test('$linkMode macos min version $macosVersion', () async {
        const target = Architecture.arm64;
        final tempUri = await tempDirForTest();
        final out1Uri = tempUri.resolve('out1/');
        await Directory.fromUri(out1Uri).create();
        final out2Uri = tempUri.resolve('out2/');
        await Directory.fromUri(out1Uri).create();
        final lib1Uri = await buildLib(
          out1Uri,
          out2Uri,
          target,
          macosVersion,
          linkMode,
        );

        final otoolResult = await runProcess(
          executable: Uri.file('otool'),
          arguments: ['-l', lib1Uri.path],
          logger: logger,
        );
        expect(otoolResult.exitCode, 0);
        expect(otoolResult.stdout, contains('minos $macosVersion.0'));
      });
    }
  }
}

Future<Uri> buildLib(
  Uri tempUri,
  Uri tempUri2,
  Architecture targetArchitecture,
  int targetMacOSVersion,
  LinkMode linkMode,
) async {
  final addCUri = packageUri.resolve('test/cbuilder/testfiles/add/src/add.c');
  const name = 'add';

  final buildInputBuilder =
      BuildInputBuilder()
        ..setupShared(
          packageName: name,
          packageRoot: tempUri,
          outputFile: tempUri.resolve('output.json'),
          outputDirectory: tempUri,
          outputDirectoryShared: tempUri2,
        )
        ..config.setupBuild(linkingEnabled: false)
        ..addExtension(
          CodeAssetExtension(
            targetOS: OS.macOS,
            targetArchitecture: targetArchitecture,
            linkModePreference:
                linkMode == DynamicLoadingBundled()
                    ? LinkModePreference.dynamic
                    : LinkModePreference.static,
            macOS: MacOSCodeConfig(targetVersion: targetMacOSVersion),
            cCompiler: cCompiler,
          ),
        );

  final buildInput = BuildInput(buildInputBuilder.json);
  final buildOutput = BuildOutputBuilder();

  final cbuilder = CBuilder.library(
    name: name,
    assetName: name,
    sources: [addCUri.toFilePath()],
    buildMode: BuildMode.release,
  );
  await cbuilder.run(input: buildInput, output: buildOutput, logger: logger);

  final libUri = buildInput.outputDirectory.resolve(
    OS.iOS.libraryFileName(name, linkMode),
  );
  return libUri;
}

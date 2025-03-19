// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This file is generated, do not edit.

// ignore_for_file: unused_element

import 'dart:io';

class Asset {
  final Map<String, Object?> json;

  final List<Object> path;

  JsonReader get _reader => JsonReader(json, path);

  Asset.fromJson(this.json, {this.path = const []});

  Asset({required String type}) : json = {}, path = const [] {
    _type = type;
    json.sortOnKey();
  }

  String get type => _reader.get<String>('type');

  set _type(String value) {
    json.setOrRemove('type', value);
  }

  @override
  String toString() => 'Asset($json)';
}

class BuildConfig extends Config {
  BuildConfig.fromJson(super.json, {super.path}) : super.fromJson();

  BuildConfig({required super.buildAssetTypes, required bool linkingEnabled})
    : super() {
    _linkingEnabled = linkingEnabled;
    json.sortOnKey();
  }

  /// Setup all fields for [BuildConfig] that are not in
  /// [Config].
  void setup({required bool linkingEnabled}) {
    _linkingEnabled = linkingEnabled;
    json.sortOnKey();
  }

  bool get linkingEnabled => _reader.get<bool>('linking_enabled');

  set _linkingEnabled(bool value) {
    json.setOrRemove('linking_enabled', value);
  }

  @override
  String toString() => 'BuildConfig($json)';
}

class BuildInput extends HookInput {
  BuildInput.fromJson(super.json, {super.path}) : super.fromJson();

  BuildInput({
    required super.config,
    Map<String, Map<String, Object?>>? dependencyMetadata,
    required super.outDir,
    required super.outDirShared,
    super.outFile,
    required super.packageName,
    required super.packageRoot,
    required super.version,
  }) : super() {
    _dependencyMetadata = dependencyMetadata;
    json.sortOnKey();
  }

  /// Setup all fields for [BuildInput] that are not in
  /// [HookInput].
  void setup({Map<String, Map<String, Object?>>? dependencyMetadata}) {
    _dependencyMetadata = dependencyMetadata;
    json.sortOnKey();
  }

  @override
  BuildConfig get config {
    final jsonValue = _reader.map$('config');
    return BuildConfig.fromJson(jsonValue, path: [...path, 'config']);
  }

  Map<String, Map<String, Object?>>? get dependencyMetadata =>
      _reader.optionalMap<Map<String, Object?>>('dependency_metadata');

  set _dependencyMetadata(Map<String, Map<String, Object?>>? value) {
    json.setOrRemove('dependency_metadata', value);
  }

  @override
  String toString() => 'BuildInput($json)';
}

class BuildOutput extends HookOutput {
  BuildOutput.fromJson(super.json, {super.path}) : super.fromJson();

  BuildOutput({
    super.assets,
    Map<String, List<Asset>>? assetsForLinking,
    super.dependencies,
    Map<String, Object?>? metadata,
    required super.timestamp,
    required super.version,
  }) : super() {
    this.assetsForLinking = assetsForLinking;
    this.metadata = metadata;
    json.sortOnKey();
  }

  /// Setup all fields for [BuildOutput] that are not in
  /// [HookOutput].
  void setup({
    Map<String, List<Asset>>? assetsForLinking,
    Map<String, Object?>? metadata,
  }) {
    this.assetsForLinking = assetsForLinking;
    this.metadata = metadata;
    json.sortOnKey();
  }

  Map<String, List<Asset>>? get assetsForLinking {
    final jsonValue = _reader.optionalMap('assetsForLinking');
    if (jsonValue == null) {
      return null;
    }
    final result = <String, List<Asset>>{};
    for (final MapEntry(:key, :value) in jsonValue.entries) {
      var index = 0;
      result[key] = [
        for (final item in value as List<Object?>)
          Asset.fromJson(
            item as Map<String, Object?>,
            path: [...path, key, index++],
          ),
      ];
    }
    return result;
  }

  set assetsForLinking(Map<String, List<Asset>>? value) {
    if (value == null) {
      json.remove('assetsForLinking');
    } else {
      json['assetsForLinking'] = {
        for (final MapEntry(:key, :value) in value.entries)
          key: [for (final item in value) item.json],
      };
    }
    json.sortOnKey();
  }

  Map<String, Object?>? get metadata => _reader.optionalMap('metadata');

  set metadata(Map<String, Object?>? value) {
    json.setOrRemove('metadata', value);
    json.sortOnKey();
  }

  @override
  String toString() => 'BuildOutput($json)';
}

class Config {
  final Map<String, Object?> json;

  final List<Object> path;

  JsonReader get _reader => JsonReader(json, path);

  Config.fromJson(this.json, {this.path = const []});

  Config({required List<String> buildAssetTypes}) : json = {}, path = const [] {
    this.buildAssetTypes = buildAssetTypes;
    json.sortOnKey();
  }

  List<String> get buildAssetTypes => _reader.stringList('build_asset_types');

  set buildAssetTypes(List<String> value) {
    json['build_asset_types'] = value;
    json.sortOnKey();
  }

  @override
  String toString() => 'Config($json)';
}

class HookInput {
  final Map<String, Object?> json;

  final List<Object> path;

  JsonReader get _reader => JsonReader(json, path);

  HookInput.fromJson(this.json, {this.path = const []});

  HookInput({
    required Config config,
    required Uri outDir,
    required Uri outDirShared,
    Uri? outFile,
    required String packageName,
    required Uri packageRoot,
    required String version,
  }) : json = {},
       path = const [] {
    this.config = config;
    this.outDir = outDir;
    this.outDirShared = outDirShared;
    this.outFile = outFile;
    this.packageName = packageName;
    this.packageRoot = packageRoot;
    this.version = version;
    json.sortOnKey();
  }

  Config get config {
    final jsonValue = _reader.map$('config');
    return Config.fromJson(jsonValue, path: [...path, 'config']);
  }

  set config(Config value) {
    json['config'] = value.json;
    json.sortOnKey();
  }

  Uri get outDir => _reader.path$('out_dir');

  set outDir(Uri value) {
    json['out_dir'] = value.toFilePath();
    json.sortOnKey();
  }

  Uri get outDirShared => _reader.path$('out_dir_shared');

  set outDirShared(Uri value) {
    json['out_dir_shared'] = value.toFilePath();
    json.sortOnKey();
  }

  Uri? get outFile => _reader.optionalPath('out_file');

  set outFile(Uri? value) {
    json.setOrRemove('out_file', value?.toFilePath());
    json.sortOnKey();
  }

  String get packageName => _reader.get<String>('package_name');

  set packageName(String value) {
    json.setOrRemove('package_name', value);
    json.sortOnKey();
  }

  Uri get packageRoot => _reader.path$('package_root');

  set packageRoot(Uri value) {
    json['package_root'] = value.toFilePath();
    json.sortOnKey();
  }

  String get version => _reader.get<String>('version');

  set version(String value) {
    json.setOrRemove('version', value);
    json.sortOnKey();
  }

  @override
  String toString() => 'HookInput($json)';
}

class HookOutput {
  final Map<String, Object?> json;

  final List<Object> path;

  JsonReader get _reader => JsonReader(json, path);

  HookOutput.fromJson(this.json, {this.path = const []});

  HookOutput({
    List<Asset>? assets,
    List<Uri>? dependencies,
    required String timestamp,
    required String version,
  }) : json = {},
       path = const [] {
    this.assets = assets;
    this.dependencies = dependencies;
    this.timestamp = timestamp;
    this.version = version;
    json.sortOnKey();
  }

  List<Asset>? get assets {
    var index = 0;
    return _reader.optionalListParsed(
      'assets',
      (e) => Asset.fromJson(
        e as Map<String, Object?>,
        path: [...path, 'assets', index++],
      ),
    );
  }

  set assets(List<Asset>? value) {
    if (value == null) {
      json.remove('assets');
    } else {
      json['assets'] = [for (final item in value) item.json];
    }
    json.sortOnKey();
  }

  List<Uri>? get dependencies => _reader.optionalPathList('dependencies');

  set dependencies(List<Uri>? value) {
    json.setOrRemove('dependencies', value?.toJson());
    json.sortOnKey();
  }

  String get timestamp => _reader.get<String>('timestamp');

  set timestamp(String value) {
    json.setOrRemove('timestamp', value);
    json.sortOnKey();
  }

  String get version => _reader.get<String>('version');

  set version(String value) {
    json.setOrRemove('version', value);
    json.sortOnKey();
  }

  @override
  String toString() => 'HookOutput($json)';
}

class LinkInput extends HookInput {
  LinkInput.fromJson(super.json, {super.path}) : super.fromJson();

  LinkInput({
    List<Asset>? assets,
    required super.config,
    required super.outDir,
    required super.outDirShared,
    super.outFile,
    required super.packageName,
    required super.packageRoot,
    Uri? resourceIdentifiers,
    required super.version,
  }) : super() {
    _assets = assets;
    _resourceIdentifiers = resourceIdentifiers;
    json.sortOnKey();
  }

  /// Setup all fields for [LinkInput] that are not in
  /// [HookInput].
  void setup({List<Asset>? assets, Uri? resourceIdentifiers}) {
    _assets = assets;
    _resourceIdentifiers = resourceIdentifiers;
    json.sortOnKey();
  }

  List<Asset>? get assets {
    var index = 0;
    return _reader.optionalListParsed(
      'assets',
      (e) => Asset.fromJson(
        e as Map<String, Object?>,
        path: [...path, 'assets', index++],
      ),
    );
  }

  set _assets(List<Asset>? value) {
    if (value == null) {
      json.remove('assets');
    } else {
      json['assets'] = [for (final item in value) item.json];
    }
  }

  Uri? get resourceIdentifiers => _reader.optionalPath('resource_identifiers');

  set _resourceIdentifiers(Uri? value) {
    json.setOrRemove('resource_identifiers', value?.toFilePath());
  }

  @override
  String toString() => 'LinkInput($json)';
}

class LinkOutput extends HookOutput {
  LinkOutput.fromJson(super.json, {super.path}) : super.fromJson();

  LinkOutput({
    super.assets,
    super.dependencies,
    required super.timestamp,
    required super.version,
  }) : super();

  @override
  String toString() => 'LinkOutput($json)';
}

class JsonReader {
  /// The JSON Object this reader is reading.
  final Map<String, Object?> json;

  /// The path traversed by readers of the surrounding JSON.
  ///
  /// Contains [String] property keys and [int] indices.
  ///
  /// This is used to give more precise error messages.
  final List<Object> path;

  JsonReader(this.json, this.path);

  T get<T extends Object?>(String key) {
    final value = json[key];
    if (value is T) return value;
    final pathString = _jsonPathToString([key]);
    if (value == null) {
      throw FormatException("No value was provided for '$pathString'.");
    }
    throwFormatException(value, T, [key]);
  }

  List<T> list<T extends Object?>(String key) =>
      _castList<T>(get<List<Object?>>(key), key);

  List<T>? optionalList<T extends Object?>(String key) =>
      switch (get<List<Object?>?>(key)?.cast<T>()) {
        null => null,
        final l => _castList<T>(l, key),
      };

  /// [List.cast] but with [FormatException]s.
  List<T> _castList<T extends Object?>(List<Object?> list, String key) {
    var index = 0;
    for (final value in list) {
      if (value is! T) {
        throwFormatException(value, T, [key, index]);
      }
      index++;
    }
    return list.cast();
  }

  List<T>? optionalListParsed<T extends Object?>(
    String key,
    T Function(Object?) elementParser,
  ) {
    final jsonValue = optionalList(key);
    if (jsonValue == null) return null;
    return [for (final element in jsonValue) elementParser(element)];
  }

  Map<String, T> map$<T extends Object?>(String key) =>
      _castMap<T>(get<Map<String, Object?>>(key), key);

  Map<String, T>? optionalMap<T extends Object?>(String key) =>
      switch (get<Map<String, Object?>?>(key)) {
        null => null,
        final m => _castMap<T>(m, key),
      };

  /// [Map.cast] but with [FormatException]s.
  Map<String, T> _castMap<T extends Object?>(
    Map<String, Object?> map_,
    String parentKey,
  ) {
    for (final MapEntry(:key, :value) in map_.entries) {
      if (value is! T) {
        throwFormatException(value, T, [parentKey, key]);
      }
    }
    return map_.cast();
  }

  List<String>? optionalStringList(String key) => optionalList<String>(key);

  List<String> stringList(String key) => list<String>(key);

  Uri path$(String key) => _fileSystemPathToUri(get<String>(key));

  Uri? optionalPath(String key) {
    final value = get<String?>(key);
    if (value == null) return null;
    return _fileSystemPathToUri(value);
  }

  List<Uri>? optionalPathList(String key) {
    final strings = optionalStringList(key);
    if (strings == null) {
      return null;
    }
    return [for (final string in strings) _fileSystemPathToUri(string)];
  }

  static Uri _fileSystemPathToUri(String path) {
    if (path.endsWith(Platform.pathSeparator)) {
      return Uri.directory(path);
    }
    return Uri.file(path);
  }

  String _jsonPathToString(List<Object> pathEnding) =>
      [...path, ...pathEnding].join('.');

  Never throwFormatException(
    Object? value,
    Type expectedType,
    List<Object> pathExtension,
  ) {
    final pathString = _jsonPathToString(pathExtension);
    throw FormatException(
      "Unexpected value '$value' (${value.runtimeType}) for '$pathString'. "
      'Expected a $expectedType.',
    );
  }
}

extension on Map<String, Object?> {
  void setOrRemove(String key, Object? value) {
    if (value == null) {
      remove(key);
    } else {
      this[key] = value;
    }
  }
}

extension on List<Uri> {
  List<String> toJson() => [for (final uri in this) uri.toFilePath()];
}

extension<K extends Comparable<K>, V extends Object?> on Map<K, V> {
  void sortOnKey() {
    final result = <K, V>{};
    final keysSorted = keys.toList()..sort();
    for (final key in keysSorted) {
      result[key] = this[key] as V;
    }
    clear();
    addAll(result);
  }
}

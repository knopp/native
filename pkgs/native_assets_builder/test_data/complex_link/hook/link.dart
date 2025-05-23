// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:native_assets_cli/data_assets.dart';

void main(List<String> args) async {
  await link(
    args,
    (input, output) async =>
        output.assets.data.addAll(treeshake(input.assets.data)),
  );
}

Iterable<DataAsset> treeshake(Iterable<DataAsset> assets) =>
    assets.where((asset) => !asset.id.endsWith('assets/data_helper_2.json'));

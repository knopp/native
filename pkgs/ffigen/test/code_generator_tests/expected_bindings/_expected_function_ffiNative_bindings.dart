// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

/// Just a test function
/// heres another line
@ffi.Native<ffi.Int32 Function()>(symbol: 'noParam')
external int noParam();

@ffi.Native<ffi.Uint8 Function(ffi.Int32, ffi.Uint8)>(
    symbol: 'withPrimitiveParam')
external int withPrimitiveParam(
  int a,
  int b,
);

@ffi.Native<
    ffi.Pointer<ffi.Double> Function(ffi.Pointer<ffi.Int32>,
        ffi.Pointer<ffi.Pointer<ffi.Uint8>>)>(symbol: 'withPointerParam')
external ffi.Pointer<ffi.Double> withPointerParam(
  ffi.Pointer<ffi.Int32> a,
  ffi.Pointer<ffi.Pointer<ffi.Uint8>> b,
);

/// A function with isLeaf: true
@ffi.Native<ffi.Int32 Function(ffi.Int32)>(symbol: 'leafFunc', isLeaf: true)
external int leafFunc(
  int a,
);

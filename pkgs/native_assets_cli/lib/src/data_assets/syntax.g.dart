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

  Asset({String? type}) : json = {}, path = const [] {
    _type = type;
    json.sortOnKey();
  }

  String? get type => _reader.get<String?>('type');

  set _type(String? value) {
    json.setOrRemove('type', value);
  }

  List<String> _validateType() => _reader.validate<String?>('type');

  List<String> validate() => [..._validateType()];

  @override
  String toString() => 'Asset($json)';
}

class DataAsset extends Asset {
  DataAsset.fromJson(super.json, {super.path}) : super.fromJson();

  DataAsset({required Uri file, required String name, required String package})
    : super(type: 'data') {
    _file = file;
    _name = name;
    _package = package;
    json.sortOnKey();
  }

  /// Setup all fields for [DataAsset] that are not in
  /// [Asset].
  void setup({
    required Uri file,
    required String name,
    required String package,
  }) {
    _file = file;
    _name = name;
    _package = package;
    json.sortOnKey();
  }

  Uri get file => _reader.path$('file');

  set _file(Uri value) {
    json['file'] = value.toFilePath();
  }

  List<String> _validateFile() => _reader.validatePath('file');

  String get name => _reader.get<String>('name');

  set _name(String value) {
    json.setOrRemove('name', value);
  }

  List<String> _validateName() => _reader.validate<String>('name');

  String get package => _reader.get<String>('package');

  set _package(String value) {
    json.setOrRemove('package', value);
  }

  List<String> _validatePackage() => _reader.validate<String>('package');

  @override
  List<String> validate() => [
    ...super.validate(),
    ..._validateFile(),
    ..._validateName(),
    ..._validatePackage(),
  ];

  @override
  String toString() => 'DataAsset($json)';
}

extension DataAssetExtension on Asset {
  bool get isDataAsset => type == 'data';

  DataAsset get asDataAsset => DataAsset.fromJson(json, path: path);
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
    throwFormatException(value, T, [key]);
  }

  List<String> validate<T extends Object?>(String key) {
    final value = json[key];
    if (value is T) return [];
    return [
      errorString(value, T, [key]),
    ];
  }

  List<T> list<T extends Object?>(String key) =>
      _castList<T>(get<List<Object?>>(key), key);

  List<String> validateList<T extends Object?>(String key) {
    final listErrors = validate<List<Object?>>(key);
    if (listErrors.isNotEmpty) {
      return listErrors;
    }
    return _validateListElements(get<List<Object?>>(key), key);
  }

  List<T>? optionalList<T extends Object?>(String key) =>
      switch (get<List<Object?>?>(key)?.cast<T>()) {
        null => null,
        final l => _castList<T>(l, key),
      };

  List<String> validateOptionalList<T extends Object?>(String key) {
    final listErrors = validate<List<Object?>?>(key);
    if (listErrors.isNotEmpty) {
      return listErrors;
    }
    final list = get<List<Object?>?>(key);
    if (list == null) {
      return [];
    }
    return _validateListElements(list, key);
  }

  /// [List.cast] but with [FormatException]s.
  List<T> _castList<T extends Object?>(List<Object?> list, String key) {
    for (final (index, value) in list.indexed) {
      if (value is! T) {
        throwFormatException(value, T, [key, index]);
      }
    }
    return list.cast();
  }

  List<String> _validateListElements<T extends Object?>(
    List<Object?> list,
    String key,
  ) {
    final result = <String>[];
    for (final (index, value) in list.indexed) {
      if (value is! T) {
        result.add(errorString(value, T, [key, index]));
      }
    }
    return result;
  }

  Map<String, T> map$<T extends Object?>(String key) =>
      _castMap<T>(get<Map<String, Object?>>(key), key);

  List<String> validateMap<T extends Object?>(String key) {
    final mapErrors = validate<Map<String, Object?>>(key);
    if (mapErrors.isNotEmpty) {
      return mapErrors;
    }
    return _validateMapElements<T>(get<Map<String, Object?>>(key), key);
  }

  Map<String, T>? optionalMap<T extends Object?>(String key) =>
      switch (get<Map<String, Object?>?>(key)) {
        null => null,
        final m => _castMap<T>(m, key),
      };

  List<String> validateOptionalMap<T extends Object?>(String key) {
    final mapErrors = validate<Map<String, Object?>?>(key);
    if (mapErrors.isNotEmpty) {
      return mapErrors;
    }
    final map = get<Map<String, Object?>?>(key);
    if (map == null) {
      return [];
    }
    return _validateMapElements<T>(map, key);
  }

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

  List<String> _validateMapElements<T extends Object?>(
    Map<String, Object?> map_,
    String parentKey,
  ) {
    final result = <String>[];
    for (final MapEntry(:key, :value) in map_.entries) {
      if (value is! T) {
        result.add(errorString(value, T, [parentKey, key]));
      }
    }
    return result;
  }

  List<String>? optionalStringList(String key) => optionalList<String>(key);

  List<String> validateOptionalStringList(String key) =>
      validateOptionalList<String>(key);

  List<String> stringList(String key) => list<String>(key);

  List<String> validateStringList(String key) => validateList<String>(key);

  Uri path$(String key) => _fileSystemPathToUri(get<String>(key));

  List<String> validatePath(String key) => validate<String>(key);

  Uri? optionalPath(String key) {
    final value = get<String?>(key);
    if (value == null) return null;
    return _fileSystemPathToUri(value);
  }

  List<String> validateOptionalPath(String key) => validate<String?>(key);

  List<Uri>? optionalPathList(String key) {
    final strings = optionalStringList(key);
    if (strings == null) {
      return null;
    }
    return [for (final string in strings) _fileSystemPathToUri(string)];
  }

  List<String> validateOptionalPathList(String key) =>
      validateOptionalStringList(key);

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
    throw FormatException(errorString(value, expectedType, pathExtension));
  }

  String errorString(
    Object? value,
    Type expectedType,
    List<Object> pathExtension,
  ) {
    final pathString = _jsonPathToString(pathExtension);
    if (value == null) {
      return "No value was provided for '$pathString'."
          ' Expected a $expectedType.';
    }
    return "Unexpected value '$value' (${value.runtimeType}) for '$pathString'."
        ' Expected a $expectedType.';
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

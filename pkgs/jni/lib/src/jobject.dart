// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'accessors.dart';
import 'jni.dart';
import 'jreference.dart';
import 'lang/jstring.dart';
import 'types.dart';

final class JObjectType extends JObjType<JObject> {
  const JObjectType();

  @override
  String get signature => 'Ljava/lang/Object;';

  @override
  JObject fromReference(JReference reference) =>
      JObject.fromReference(reference);

  @override
  JObjType get superType => const JObjectType();

  // TODO(#70): Once interface implementation lands, other than [superType],
  // we should have a list of implemented interfaces.

  @override
  final int superCount = 0;

  @override
  int get hashCode => (JObjectType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == JObjectType && other is JObjectType;
  }
}

/// A high-level wrapper for JNI global object reference.
///
/// This is the base class for classes generated by `jnigen`.
class JObject implements Finalizable {
  final JReference reference;

  late final JObjType<JObject> $type = type;

  /// The type which includes information such as the signature of this class.
  static const JObjType<JObject> type = JObjectType();

  /// Constructs a [JObject] with the underlying [reference].
  JObject.fromReference(this.reference);

  /// Returns [JClass] corresponding to concrete class of this object.
  ///
  /// This may be a subclass of compile-time class.
  JClass get jClass {
    final classRef = Jni.env.GetObjectClass(reference.pointer);
    if (classRef == nullptr) {
      Jni.accessors.throwException(Jni.env.ExceptionOccurred());
    }
    return JClass.fromReference(JGlobalReference(classRef));
  }

  bool get isNull => reference.isNull;

  /// Releases the underlying [reference].
  ///
  /// Releasing in one isolate while using or releasing in another isolate might
  /// crash in the JNI layer.
  void release() {
    reference.release();
  }

  /// Casts this object to another [type].
  ///
  /// If [releaseOriginal] is `true`, the casted object will be released.
  T castTo<T extends JObject>(
    JObjType<T> type, {
    bool releaseOriginal = false,
  }) {
    assert(
      () {
        final jClass = type.jClass.reference.toPointer();
        final canBeCasted = Jni.env.IsInstanceOf(reference.pointer, jClass);
        Jni.env.DeleteGlobalRef(jClass);
        return canBeCasted;
      }(),
      'The object must be of type "${type.signature}".',
    );
    if (releaseOriginal) {
      final ret = type.fromReference(JGlobalReference(reference.pointer));
      reference.setAsReleased();
      return ret;
    }
    final newRef = JGlobalReference(Jni.env.NewGlobalRef(reference.pointer));
    return type.fromReference(newRef);
  }

  static final _class = JClass.forName('java/lang/Object');

  static final _hashCodeId = _class.instanceMethodId(r'hashCode', r'()I');

  @override
  int get hashCode => _hashCodeId(this, const jintType(), []);

  static final _equalsId =
      _class.instanceMethodId(r'equals', r'(Ljava/lang/Object;)Z');
  @override
  bool operator ==(Object other) {
    if (other is! JObject) {
      return false;
    }
    return _equalsId(this, const jbooleanType(), [other.reference.pointer]);
  }

  static final _toStringId =
      _class.instanceMethodId(r'toString', r'()Ljava/lang/String;');
  @override
  String toString() {
    return _toStringId(this, const JStringType(), [])
        .toDartString(releaseOriginal: true);
  }

  bool get isReleased => reference.isReleased;

  /// Registers this object to be released at the end of [arena]'s lifetime.
  void releasedBy(Arena arena) => arena.onReleaseAll(release);
}

extension JObjectUseExtension<T extends JObject> on T {
  /// Applies [callback] on this object and then delete the underlying JNI
  /// reference, returning the result of [callback].
  R use<R>(R Function(T) callback) {
    try {
      final result = callback(this);
      return result;
    } finally {
      release();
    }
  }
}

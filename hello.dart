// https://github.com/dart-lang/samples/tree/main/ffi
// https://stackoverflow.com/questions/61541354/dart-flutter-ffi-foreign-function-interface-native-callbacks-eg-sqlite3-exec

import 'dart:ffi' as ffi;
import 'dart:io' show Directory;

import 'package:path/path.dart' as path;

typedef HelloWorldFunc = ffi.Void Function();
typedef HelloWorld = void Function();

typedef OnSensorUpdateFunc = ffi.Int32 Function(ffi.Pointer<ffi.Uint8>);

typedef RegisterCallbackFunc = ffi.Int32 Function(
    ffi.Pointer<ffi.NativeFunction<OnSensorUpdateFunc>>);
typedef RegisterCallback = int Function(
    ffi.Pointer<ffi.NativeFunction<OnSensorUpdateFunc>>);

const except = -1;

void main() {
  var libraryPath = path.join(
      Directory.current.path, 'hello_library', 'build', 'libhello.so');

  final dylib = ffi.DynamicLibrary.open(libraryPath);

  final HelloWorld hello = dylib
      .lookup<ffi.NativeFunction<HelloWorldFunc>>('hello_world')
      .asFunction();

  final RegisterCallback reg = dylib
      .lookup<ffi.NativeFunction<RegisterCallbackFunc>>('registerCallback')
      .asFunction();

  reg(ffi.Pointer.fromFunction<OnSensorUpdateFunc>(callback, except));

  hello();
}

int callback(ffi.Pointer<ffi.Uint8> data) {
  print("Hello World in dart called by c lib");
  return 0;
}

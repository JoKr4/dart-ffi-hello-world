// https://github.com/dart-lang/samples/tree/main/ffi
// https://stackoverflow.com/questions/61541354/dart-flutter-ffi-foreign-function-interface-native-callbacks-eg-sqlite3-exec

import 'dart:ffi' as ffi;
import 'dart:io' show Directory;
import 'dart:typed_data';

import 'package:path/path.dart' as path;

typedef HelloWorldFunc = ffi.Void Function();
typedef HelloWorld = void Function();

typedef OnSensorUpdateFunc = ffi.Int32 Function(
    ffi.Pointer<ffi.UnsignedChar>, ffi.Int32);

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

int callback(ffi.Pointer<ffi.UnsignedChar> data, int size) {
  print("Hello World in dart called by c lib");
  var sensorValues = data.toUint8List(size);
  for (var i = 0; i < size; i++) {
    print("Sensor $i Value ${sensorValues![i]}");
  }
  return 0;
}

// https://stackoverflow.com/questions/60879616/dart-flutter-getting-data-array-from-c-c-using-ffi
extension UnsignedCharPointerExtension on ffi.Pointer<ffi.UnsignedChar> {
  Uint8List? toUint8List(int length) {
    if (this == ffi.nullptr) {
      return null;
    }
    return cast<ffi.Uint8>().asTypedList(length);
  }
}

# dart-ffi-hello-world

Call c code from dart and dart code from c  
(to be used in my project where sensor data from a native lib should notify dart/flutter for new data)

Build the c library:
```
mkdir hello_library/build
cd hello_library/build
cmake ..
cmake --build .
```
(assuming you have gcc and cmake available)

and then call dart:
```
cd ..
cd ..
dart hello.dart
```
will print:
```
Hello World in c lib
Hello World in dart called by c lib
```
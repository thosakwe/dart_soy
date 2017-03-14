# soy
[![version 0.0.1](https://img.shields.io/badge/pub-0.0.1-red.svg)](https://pub.dartlang.org/packages/soy)
[![build status](https://travis-ci.org/thosakwe/dart_soy.svg)](https://travis-ci.org/thosakwe/dart_soy)

Parser and AST classes for Closure Templates. This will allow us to finally bring
*robust* server-rendered templates to Dart;

```dart
import 'package:soy/soy.dart' as soy;

main() {
    var ast = soy.parse(...);
}
```

# TODO
* [ ] API Documentation
* [ ] Expression Parser
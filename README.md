# soy
[![version 0.0.0](https://img.shields.io/badge/pub-0.0.0-red.svg)](https://pub.dartlang.org/packages/soy)
[![build status](https://travis-ci.org/thosakwe/dart_soy.svg)](https://travis-ci.org/thosakwe/dart_soy)

Parser and AST classes for Closure Templates.
Currently missing support for [referencing data](https://developers.google.com/closure/templates/docs/concepts#referencing-data),
i.e. **`{$ij.foo}`**.

Eventually, support for parsing the comments will also be included.

```dart
import 'package:soy/soy.dart' as soy;

main() {
    var ast = soy.parse(...);
}
```
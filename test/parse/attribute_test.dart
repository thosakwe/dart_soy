import 'package:test/test.dart';
import 'common.dart';

main() {
  test('basic', () {
    var parser = makeParser('{private="true"}')..read();
    var attr = parser.parseAttribute();
    expect(attr.name, equals('private'));
    expect(attr.value, equals('true'));
  });
}

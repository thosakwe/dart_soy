import 'package:test/test.dart';
import 'common.dart';

main() {
  test('basic', () {
    var parser = makeParser('{.foo}')..read();
    var clazz = parser.parseClassContext();
    expect(clazz.name, equals('foo'));
  });
}

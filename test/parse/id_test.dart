import 'package:soy/soy.dart' as soy;
import 'package:test/test.dart';
import 'common.dart';

main() {
  test('basic', () {
    var parser = makeParser('{foo}')..read();
    var id = parser.parseIdentifier();
    expect(id.name, equals('foo'));
  });

  test('member', () {
    var parser = makeParser('{foo.bar.baz}')..read();
    var id = parser.parseIdentifier();
    expect(id, new isInstanceOf<soy.IdentifierMemberContext>());
    expect(id.name, equals('foo.bar.baz'));
  });
}

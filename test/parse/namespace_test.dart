import 'package:soy/soy.dart' as soy;
import 'package:test/test.dart';
import 'common.dart';

main() {
    test('basic', () {
      var parser = makeParser('{namespace foo private="true" .bar}');
      var namespace = parser.parseNamespaceDeclaration();
      expect(namespace.name, equals('foo'));
      expect(namespace.members, hasLength(2));
      expect(namespace.members[0], new isInstanceOf<soy.AttributeContext>());
      expect(namespace.members[1], new isInstanceOf<soy.ClassContext>());
    });
}

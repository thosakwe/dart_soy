import 'package:soy/soy.dart' as soy;
import 'package:test/test.dart';
import 'common.dart';

main() {
  group('opening tag', () {
    test('self-closing', () {
      var parser = makeParser('{foo bar="baz" .quux /}');
      var tag = parser.parseOpeningTag();
      expect(tag.SLASH, isNotNull);
      expect(tag.tagName, equals('foo'));
      expect(tag.members, hasLength(2));
      expect(tag.members[0], new isInstanceOf<soy.AttributeContext>());
      expect(tag.members[1], new isInstanceOf<soy.ClassContext>());
    });

    test('normal', () {
      var parser = makeParser('{foo}');
      var tag = parser.parseOpeningTag();
      expect(tag.SLASH, isNull);
      expect(tag.tagName, equals('foo'));
      expect(tag.members, isEmpty);
    });
  });

  test('closing tag', () {
    var parser = makeParser('{/foo}');
    var tag = parser.parseClosingTag();
    expect(tag.SLASH, isNotNull);
    expect(tag.tagName, equals('foo'));
    expect(tag.members, isEmpty);
  });
}

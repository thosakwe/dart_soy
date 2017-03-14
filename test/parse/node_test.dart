import 'package:soy/soy.dart' as soy;
import 'package:test/test.dart';
import 'common.dart';

main() {
  test('self-closing', () {
    var parser = makeParser('{foo bar="baz" .quux /}');
    var node = parser.parseNode();
    expect(node.openingTag, isNotNull);
    expect(node.closingTag, isNull);
    expect(node.tagName, equals('foo'));
    expect(node.members, isEmpty);
    expect(node.openingTag.members, hasLength(2));
    expect(
        node.openingTag.members[0], new isInstanceOf<soy.AttributeContext>());
    expect(node.openingTag.members[1], new isInstanceOf<soy.ClassContext>());
  });

  test('normal', () {
    var parser = makeParser('''
{foo bar="baz" .quux}
  {bar .baz quux="foo" /}
  {baz quux="foo" .bar}{/baz}
  quux
{/foo}
    ''');
    var node = parser.parseNode();
    expect(node.openingTag, isNotNull);
    expect(node.closingTag, isNotNull);
    expect(node.tagName, equals('foo'));
    expect(node.members, hasLength(3));
    expect(node.openingTag.members, hasLength(2));
    expect(
        node.openingTag.members[0], new isInstanceOf<soy.AttributeContext>());
    expect(node.openingTag.members[1], new isInstanceOf<soy.ClassContext>());
    expect(node.members.take(2), everyElement(new isInstanceOf<soy.NodeContext>()));
    expect(node.members.last, new isInstanceOf<soy.TextContext>());
  });

  test('referenced data', () {
    var parser = makeParser(r'{artist}{$michael.jackson}{/artist}');
    var node = parser.parseNode();
    expect(node.openingTag, isNotNull);
    expect(node.closingTag, isNotNull);
    expect(node.tagName, equals('artist'));
    expect(node.members, hasLength(1));
    expect(node.members.first, new isInstanceOf<soy.InterpolationContext>());

    var ref = node.members.first as soy.InterpolationContext;
    expect(ref.openingTag, isNotNull);
    expect(ref.closingTag, isNull);
    expect(ref.members, isEmpty);
    expect(ref.tagName, equals(r'$michael.jackson'));
  });
}

import 'package:test/test.dart';
import 'common.dart';

main() {
  test('basic', () {
    var parser = makeParser('''
    {namespace foo}
    {foo bar="baz" .quux}
      {lorem .ipsum /}
    {/foo}
    ''');
    var template = parser.parseTemplate();
    expect(template.namespace.name, equals('foo'));
    expect(template.nodes, hasLength(1));
    expect(template.nodes.first.tagName, equals('foo'));
  });
}
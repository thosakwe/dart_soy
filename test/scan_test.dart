import 'package:soy/src/text/text.dart';
import 'package:test/test.dart';
import 'common.dart';

main() {
  test('namespace', () {
    expect(
        '{namespace thosakwe.dart_soy}',
        equalsScanned([
          TokenType.LBRACE,
          TokenType.ID,
          TokenType.ID,
          TokenType.DOT,
          TokenType.ID,
          TokenType.RBRACE
        ]));
  });

  test('nested', () {
    expect(
        '''
    {template .example}
      {call .helper /}
    {/template}
    ''',
        equalsScanned([
          TokenType.LBRACE,
          TokenType.ID,
          TokenType.DOT,
          TokenType.ID,
          TokenType.RBRACE,
          TokenType.LBRACE,
          TokenType.ID,
          TokenType.DOT,
          TokenType.ID,
          TokenType.SLASH,
          TokenType.RBRACE,
          TokenType.LBRACE,
          TokenType.SLASH,
          TokenType.ID,
          TokenType.RBRACE
        ]));
  });

  test('helper', () {
    expect(
        '{template .helper private="true"}',
        equalsScanned([
          TokenType.LBRACE,
          TokenType.ID,
          TokenType.DOT,
          TokenType.ID,
          TokenType.ID,
          TokenType.EQUALS,
          TokenType.STRING,
          TokenType.RBRACE
        ]));
  });

  test('text', () {
    var HELLO_WORLD = 'hello, world!';
    var scanned = scan(HELLO_WORLD).first;
    expect(scanned.type, equals(TokenType.TEXT));
    expect(scanned.text, equals(HELLO_WORLD));
  });
}

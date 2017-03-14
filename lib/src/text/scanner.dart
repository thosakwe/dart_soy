import 'package:compiler_tools/compiler_tools.dart';
import 'package:string_scanner/string_scanner.dart';
import 'token_type.dart';

final RegExp _id = new RegExp(r'([A-Za-z0-9_]|\$)+');
final RegExp _whitespace = new RegExp(r'( |\r\n\t)+');
final RegExp SOY_COMMENT = new RegExp(r'\/\*(\w|\W)*\*\/');

final Map<Pattern, TokenType> _PATTERNS = {
  ':': TokenType.COLON,
  // r'$': TokenType.DOLLAR,
  '.': TokenType.DOT,
  '=': TokenType.EQUALS,
  '{': TokenType.LBRACE,
  '}': TokenType.RBRACE,
  '/': TokenType.SLASH,
  new RegExp(r'\@param\??'): TokenType.PARAM,
  new RegExp(r'[0-9]+(\.[0-9]+)?'): TokenType.NUMBER,
  new RegExp(r'"((\\")|([^"\n]))*"'): TokenType.STRING,
  new RegExp(r"'((\\')|([^'\n]))*'"): TokenType.STRING
};

List<Token<TokenType>> scan(String text, {sourceUrl}) {
  List<Token<TokenType>> tokens = [];
  var scanner = new SpanScanner(text, sourceUrl: sourceUrl);
  LineScannerState bufState;
  int open = 0;

  void flushBuffer() {
    if (bufState != null) {
      var span = scanner.spanFrom(bufState);

      if (span.text.trim().isNotEmpty)
        tokens.add(new Token(TokenType.TEXT, span: span));

      bufState = null;
    }
  }

  while (!scanner.isDone) {
    List<Token> potential = [];

    if (scanner.scan(SOY_COMMENT)) continue;
    if (bufState == null && scanner.scan(_whitespace)) continue;

    _PATTERNS.forEach((pattern, type) {
      if (scanner.matches(pattern)) {
        potential.add(new Token(type, span: scanner.lastSpan));

        if (type == TokenType.LBRACE)
          open++;
        else if (type == TokenType.RBRACE) {
          if (open > 0)
            open--;
          else
            throw new StateError(
                'You have more right braces than left braces.');
        }
      }
    });

    if (open > 0 && scanner.matches(_id))
      potential.add(new Token(TokenType.ID, span: scanner.lastSpan));

    if (potential.isEmpty) {
      if (bufState == null) bufState = scanner.state;
      scanner.readChar();
    } else {
      flushBuffer();

      if (potential.length > 1)
        potential.sort((a, b) => a.text.length.compareTo(b.text.length));

      var token = potential.first;
      tokens.add(token);
      scanner.scan(token.text);
    }
  }

  flushBuffer();

  if (open > 0)
    throw new StateError('You have more left braces than right braces.');

  return tokens;
}

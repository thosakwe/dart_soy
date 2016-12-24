import 'dart:async';
import 'package:string_scanner/string_scanner.dart';
import 'package:source_span/source_span.dart';
import 'token.dart';
import 'token_type.dart';

final Map<Pattern, TokenType> _PATTERNS = {
  ':': TokenType.COLON,
  r'$': TokenType.DOLLAR,
  '.': TokenType.DOT,
  '=': TokenType.EQUALS,
  '{': TokenType.LBRACE,
  '}': TokenType.RBRACE,
  '/': TokenType.SLASH,
  '@param': TokenType.PARAM,
  'namespace': TokenType.NAMESPACE,
  'template': TokenType.TEMPLATE,
  new RegExp(r'[0-9]+(\.[0-9]+)?'): TokenType.NUMBER,
  new RegExp(r'"((\\")|([^"\n]))*"'): TokenType.STRING,
  new RegExp(r"'((\\')|([^'\n]))*'"): TokenType.STRING,
  new RegExp(r'([A-Za-z_]|$)([A-Za-z0-9_]|$)*'): TokenType.ID,
};

class Scanner implements StreamTransformer<String, Token> {
  final Uri sourceUrl;

  Scanner(this.sourceUrl);

  @override
  Stream<Token> bind(Stream<String> stream) {
    var _stream = new StreamController<Token>();

    stream.listen((str) {
      var scanner = new StringScanner(str);
      var line = 1, col = 0;
      var chunkLine = 1, chunkCol = 0;
      List<int> buf = [];

      void flushBuffer() {
        if (buf.isNotEmpty) {
      var start = new SourceLocation(scanner.position,
          sourceUrl: sourceUrl, line: chunkLine, column: ++col);
          var end = new SourceLocation(scanner.position,
              sourceUrl: sourceUrl, line: line, column: col);
        }
      }

      while (!scanner.isDone) {
        List<Token> potential = [];
        var start = new SourceLocation(scanner.position,
            sourceUrl: sourceUrl, line: line, column: ++col);

        _PATTERNS.forEach((k, v) {
          if (scanner.matches(k)) {
            var text = scanner.lastMatch[0];
            var lines = text.split('\n');
            var end = new SourceLocation(scanner.position + text.length,
                sourceUrl: sourceUrl,
                line: line + lines.length - 1,
                column: lines.last.length);
            var span = new SourceSpan(start, end, text);

            potential.add(new Token(v, text, span));
          }
        });

        if (potential.isEmpty) {
          var ch = scanner.readChar();
          buf.add(ch);

          if (ch == '\n') {
            line++;
            col = 0;
          }
        } else {
          flushBuffer();
          potential.sort((a, b) => a.text.length.compareTo(b.text.length));
          var token = potential.first;
          _stream.add(token);
          scanner.position += token.text.length;
          var lines = token.text.split('\n');
          line += lines.length - 1;
          col = lines.last.length;
        }
      }

      flushBuffer();
    });

    return _stream.stream;
  }
}

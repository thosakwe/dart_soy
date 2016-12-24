import 'package:source_span/source_span.dart';
import 'token_type.dart';

class Token {
  final TokenType type;
  final String text;
  final SourceSpan span;

  Token(this.type, this.text, this.span);
}
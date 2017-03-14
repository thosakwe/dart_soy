import 'package:compiler_tools/compiler_tools.dart';
import 'package:source_span/source_span.dart';
import '../text/token_type.dart';
import 'node_member.dart';

class TextContext extends NodeContextMember {
  final Token<TokenType> TEXT;

  TextContext(this.TEXT);

  SourceSpan get span => TEXT.span;
}

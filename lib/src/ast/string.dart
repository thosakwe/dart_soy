import 'package:compiler_tools/compiler_tools.dart';
import 'package:source_span/source_span.dart';
import '../text/token_type.dart';
import 'ast_node.dart';

final RegExp _quotes = new RegExp(r'(^")|("$)');

class StringContext extends AstNode {
  final Token<TokenType> STRING;

  StringContext(this.STRING);

  SourceSpan get span => STRING.span;
  String get stringValue =>
      text.replaceAll(_quotes, ''); // TODO escapes, Unicode, etc.?
}

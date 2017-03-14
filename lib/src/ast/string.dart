import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'ast_node.dart';

final RegExp _quotes = new RegExp(r'(^")|("$)');

class StringContext extends AstNode {
  final Token<TokenType> STRING;

  StringContext(this.STRING);

  @override
  String get text => STRING.text;

  String get stringValue =>
      text.replaceAll(_quotes, ''); // TODO escapes, Unicode, etc.?
}

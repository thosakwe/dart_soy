import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'ast_node.dart';

class IdentifierContext extends AstNode {
  final Token<TokenType> ID;

  IdentifierContext(this.ID);

  String get text => ID.text;

  String get name => text;
}

class IdentifierMemberContext extends IdentifierContext {
  final Token<TokenType> DOT;
  final IdentifierContext parent;
  String _text;

  IdentifierMemberContext(this.parent, this.DOT, Token<TokenType> ID)
      : super(ID) {
    if (parent is IdentifierMemberContext) {
      var member = parent as IdentifierMemberContext;
      _text = '${member._text}.${ID.text}';
    } else {
      _text = '${parent.text}.${ID.text}';
    }
  }

  @override
  String get text => _text;
}

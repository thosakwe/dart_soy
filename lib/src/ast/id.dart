import 'package:compiler_tools/compiler_tools.dart';
import 'package:source_span/source_span.dart';
import '../text/token_type.dart';
import 'ast_node.dart';

class IdentifierContext extends AstNode {
  final Token<TokenType> ID;

  IdentifierContext(this.ID);

  SourceSpan get span => ID.span;

  String get name => text;
}

class IdentifierMemberContext extends IdentifierContext {
  final Token<TokenType> DOT;
  final IdentifierContext parent;
  SourceSpan _span, _rootSpan;
  String _text;

  IdentifierMemberContext(this.parent, this.DOT, Token<TokenType> ID)
      : super(ID) {
    _span = super.span;

    if (parent is IdentifierMemberContext) {
      var member = parent as IdentifierMemberContext;
      _rootSpan = member._rootSpan;
      _text = '${member._text}.${ID.text}';
    } else {
      _rootSpan = parent.span;
      _text = '${parent.text}.${ID.text}';
    }
  }

  @override
  SourceSpan get span => new SourceSpan(_rootSpan.start, _span.end, _text);
}

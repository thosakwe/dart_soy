import 'package:compiler_tools/compiler_tools.dart';
import 'package:source_span/source_span.dart';
import '../text/token_type.dart';
import 'ast_node.dart';
import 'id.dart';
import 'tag_member.dart';

class TagContext extends AstNode {
  final Token<TokenType> LBRACE, RBRACE, SLASH;
  final IdentifierContext identifier;
  final List<TagContextMember> members = [];

  TagContext(this.LBRACE, this.identifier, this.RBRACE, [this.SLASH]);

  @override
  SourceSpan get span => LBRACE.span.union(RBRACE.span);

  String get tagName => identifier.name;
}

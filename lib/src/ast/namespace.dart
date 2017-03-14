import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'ast_node.dart';
import 'id.dart';
import 'package:source_span/src/span.dart';
import 'tag_member.dart';

class NamespaceDeclarationContext extends AstNode {
  final Token<TokenType> LBRACE, RBRACE;
  final IdentifierContext identifier;
  final List<TagContextMember> members = [];

  NamespaceDeclarationContext(
    this.LBRACE,
    this.identifier,
    this.RBRACE,
  );

  String get name => identifier.name;

  @override
  SourceSpan get span => LBRACE.span.union(RBRACE.span);
}

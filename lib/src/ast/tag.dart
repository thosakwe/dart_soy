import 'package:compiler_tools/compiler_tools.dart';
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
  String get text {
    if (SLASH != null && members.isEmpty) {
      return '{/$tagName}';
    } else {
      var buf = new StringBuffer('{$tagName');

      for (var member in members) {
        buf.write(' ${member.text}');
      }

      if (SLASH != null) buf.write('/');

      return buf.toString() + '}';
    }
  }

  String get tagName => identifier.name;
}

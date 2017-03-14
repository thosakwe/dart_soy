import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'id.dart';
import 'tag_member.dart';

class ClassContext extends TagContextMember {
  final Token<TokenType> DOT;
  final IdentifierContext identifier;

  ClassContext(this.DOT, this.identifier);

  @override
  String get text => '.$name';

  String get name => identifier.name;
}

import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'id.dart';
import 'string.dart';
import 'tag_member.dart';

class AttributeContext extends TagContextMember {
  final IdentifierContext identifier;
  final Token<TokenType> EQUALS;
  final StringContext string;

  AttributeContext(this.identifier, this.EQUALS, this.string);

  @override
  String get text => '$name="$value"';

  String get name => identifier.text;
  String get value => string.stringValue;
}

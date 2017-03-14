import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'id.dart';
import 'node_member.dart';

class ParameterSpecificationContext extends NodeContextMember {
  final Token<TokenType> LBRACE, PARAM, COLON, RBRACE;
  final IdentifierContext identifier, type;

  ParameterSpecificationContext(this.LBRACE, this.PARAM, this.identifier,
      this.COLON, this.RBRACE, this.type);

  @override
  String get text => '{${PARAM.text} $name: ${type.name}}';

  String get name => identifier.text;

  bool get isOptional => PARAM.text.endsWith('?');
}

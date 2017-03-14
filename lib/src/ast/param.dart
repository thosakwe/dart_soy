import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'id.dart';
import 'node_member.dart';
import 'package:source_span/src/span.dart';

class ParameterSpecificationContext extends NodeContextMember {
  final Token<TokenType> LBRACE, PARAM, COLON, RBRACE;
  final IdentifierContext identifier, type;

  ParameterSpecificationContext(this.LBRACE, this.PARAM, this.identifier,
      this.COLON, this.RBRACE, this.type);

  @override
  SourceSpan get span => LBRACE.span.union(RBRACE.span);

  String get name => identifier.text;

  bool get isOptional => PARAM.text.endsWith('?');
}

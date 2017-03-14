import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'id.dart';
import 'package:source_span/src/span.dart';
import 'tag_member.dart';

class ClassContext extends TagContextMember {
  final Token<TokenType> DOT;
  final IdentifierContext identifier;

  ClassContext(this.DOT, this.identifier);

  @override
  SourceSpan get span => DOT.span.union(identifier.span);

  String get name => identifier.name;
}

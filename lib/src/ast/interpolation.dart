import 'package:compiler_tools/compiler_tools.dart';
import 'package:source_span/source_span.dart';
import '../text/token_type.dart';
import 'node_member.dart';

class InterpolationContext extends NodeContextMember {
  final Token<TokenType> INTERPOLATION;

  InterpolationContext(this.INTERPOLATION);

  SourceSpan get span => INTERPOLATION.span;
}

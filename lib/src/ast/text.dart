import 'package:compiler_tools/compiler_tools.dart';
import '../text/token_type.dart';
import 'node_member.dart';

class TextContext extends NodeContextMember {
  final Token<TokenType> TEXT;

  TextContext(this.TEXT);

  String get text => TEXT.text;
}

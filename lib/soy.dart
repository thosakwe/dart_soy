library soy;

import 'src/ast/ast.dart';
import 'src/text/text.dart';
export 'src/ast/ast.dart';

TemplateContext parse(String text, {sourceUrl}) {
  var tokens = scan(text, sourceUrl: sourceUrl);
  var parser = new Parser(tokens);
  return parser.parseTemplate();
}

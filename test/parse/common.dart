import 'package:soy/src/text/text.dart' as soy;

soy.Parser makeParser(String text) {
  var tokens = soy.scan(text);
  return new soy.Parser(tokens);
}
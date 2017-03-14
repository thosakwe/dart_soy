import 'package:matcher/matcher.dart';
import 'package:soy/src/text/text.dart';

Matcher equalsScanned(List<TokenType> sequence) => new _EqualsScanned(sequence);

class _EqualsScanned extends Matcher {
  final List<TokenType> sequence;

  _EqualsScanned(this.sequence);

  @override
  Description describe(Description description) =>
      description.add('matches this sequence when scanned: $sequence');

  @override
  bool matches(item, Map matchState) {
    var scanned = scan(item.toString().trim());
    print('Scanned "$item", got: $scanned');
    return equals(sequence)
        .matches(scanned.map((token) => token.type).toList(), matchState);
  }
}

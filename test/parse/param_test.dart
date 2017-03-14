import 'package:test/test.dart';
import 'common.dart';

main() {
  test('basic', () {
    var parser = makeParser('{@param name: string}');
    var param = parser.parseParameter();
    expect(param.name, equals('name'));
    expect(param.type.name, equals('string'));
    expect(param.isOptional, isFalse);
  });

  test('optional', () {
    var parser = makeParser('{@param? name: string}');
    var param = parser.parseParameter();
    expect(param.name, equals('name'));
    expect(param.type.name, equals('string'));
    expect(param.isOptional, isTrue);
  });
}

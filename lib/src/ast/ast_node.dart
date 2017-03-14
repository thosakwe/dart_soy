import 'package:source_span/source_span.dart';

abstract class AstNode {
  SourceSpan get span;
  String get text => span.text;
}
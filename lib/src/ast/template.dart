import 'ast_node.dart';
import 'namespace.dart';
import 'node.dart';
import 'package:source_span/src/span.dart';

class TemplateContext extends AstNode {
  final NamespaceDeclarationContext namespace;
  final NodeContext rootNode;

  TemplateContext(this.namespace, this.rootNode);

  @override
  SourceSpan get span => namespace.span.union(rootNode.span);
}

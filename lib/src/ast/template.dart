import 'ast_node.dart';
import 'namespace.dart';
import 'node.dart';
import 'package:source_span/src/span.dart';

class TemplateContext extends AstNode {
  final NamespaceDeclarationContext namespaceDeclaration;
  final NodeContext rootNode;

  TemplateContext(this.namespaceDeclaration, this.rootNode);

  @override
  SourceSpan get span => namespaceDeclaration.span.union(rootNode.span);
}

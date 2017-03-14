import 'ast_node.dart';
import 'namespace.dart';
import 'node.dart';

class TemplateContext extends AstNode {
  final NamespaceDeclarationContext namespace;
  final List<NodeContext> nodes = [];

  TemplateContext(this.namespace);

  @override
  String get text => namespace.text + nodes.map((node) => node.text).join();
}

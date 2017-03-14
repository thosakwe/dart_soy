import 'node_member.dart';
import 'package:source_span/src/span.dart';
import 'tag.dart';

class NodeContext extends NodeContextMember {
  final TagContext openingTag, closingTag;
  final List<NodeContextMember> members = [];

  NodeContext(this.openingTag, [this.closingTag]);

  @override
  SourceSpan get span => closingTag == null
      ? openingTag.span
      : openingTag.span.union(closingTag.span);

  String get tagName => openingTag.tagName;
}

class ReferencedDataContext extends NodeContext {
  ReferencedDataContext(TagContext openingTag) : super(openingTag);
}

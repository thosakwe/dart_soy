import 'node_member.dart';
import 'tag.dart';

class NodeContext extends NodeContextMember {
  final TagContext openingTag, closingTag;
  final List<NodeContextMember> members = [];

  NodeContext(this.openingTag, [this.closingTag]);

  String get text {
    var buf = new StringBuffer();
    buf.write(openingTag.text);

    if (closingTag != null) {
      members.forEach((member) => buf.write(member.text));
      buf.write(closingTag.text);
    }

    return buf.toString();
  }

  String get tagName => openingTag.tagName;
}

class InterpolationContext extends NodeContext {
  InterpolationContext(TagContext openingTag) : super(openingTag);

  @override
  String get text => openingTag.text;
}

import 'package:compiler_tools/compiler_tools.dart';
import '../ast/ast.dart';
import 'token_type.dart';

class Parser extends BaseParser<TokenType> {
  Parser(List<Token<TokenType>> tokens) : super(tokens);

  TemplateContext parseTemplate() {
    var namespaceDeclaration = parseNamespaceDeclaration();
    if (namespaceDeclaration != null) {
      var rootNode = parseNode();
      if (rootNode != null) {
        return new TemplateContext(namespaceDeclaration, rootNode);
      } else
        throw error('Expected a root node.');
    } else
      return null;
  }

  NamespaceDeclarationContext parseNamespaceDeclaration() {
    if (next(TokenType.LBRACE)) {
      var lbrace = current;
      if (next(TokenType.ID)) {
        var identifier = new IdentifierContext(current);
        if (identifier.name == 'namespace') {
          identifier = parseIdentifier();

          if (identifier == null) throw expectedType(TokenType.ID);

          List<TagContextMember> members = [];
          TagContextMember member = parseTagContextMember();

          while (member != null) {
            members.add(member);
            member = parseTagContextMember();
          }

          if (next(TokenType.RBRACE)) {
            return new NamespaceDeclarationContext(lbrace, identifier, current)
              ..members.addAll(members);
          } else
            throw expectedType(TokenType.RBRACE);
        } else
          throw error(
              'Expected a namespace declaration, not a "${identifier.name}" tag.');
      } else
        throw expectedType(TokenType.ID);
    } else
      return null;
  }

  NodeContextMember parseNodeContextMember() =>
      parseNode() ?? (parseText() ?? null);

  NodeContext parseNode() {
    var openingTag = parseOpeningTag();

    if (openingTag != null) {
      if (openingTag.SLASH != null) {
        // Self-closing
        return new NodeContext(openingTag);
      } else {
        List<NodeContextMember> members = [];
        NodeContextMember member = parseNodeContextMember();

        while (member != null) {
          members.add(member);
          member = parseNodeContextMember();
        }

        var closingTag = parseClosingTag();
        if (closingTag != null) {
          if (closingTag.tagName == openingTag.tagName) {
            return new NodeContext(openingTag, closingTag)
              ..members.addAll(members);
          } else
            throw error(
                'Missing a closing tag for node with tag name "${openingTag.tagName}". You tried ending it with a "${closingTag.tagName}".');
        } else
          throw error(
              'Node with tag name "${openingTag.tagName}" was left open.');
      }
    } else
      return null;
  }

  TagContext parseOpeningTag() {
    if (next(TokenType.LBRACE)) {
      var lbrace = current;
      if (next(TokenType.ID)) {
        var identifier = new IdentifierContext(current);
        List<TagContextMember> members = [];
        TagContextMember member = parseTagContextMember();

        while (member != null) {
          members.add(member);
          member = parseTagContextMember();
        }

        Token slash;
        if (next(TokenType.SLASH)) slash = current;

        if (next(TokenType.RBRACE)) {
          return new TagContext(lbrace, identifier, current, slash)
            ..members.addAll(members);
        } else
          throw expectedType(TokenType.RBRACE);
      } else if (peek()?.type == TokenType.SLASH) {
        // This is a closing tag, backtrack
        backtrack();
        return null;
      } else
        throw expectedType(TokenType.ID);
    } else
      return null;
  }

  TagContext parseClosingTag() {
    if (next(TokenType.LBRACE)) {
      var lbrace = current;
      if (next(TokenType.SLASH)) {
        var slash = current;
        if (next(TokenType.ID)) {
          var identifier = new IdentifierContext(current);
          if (next(TokenType.RBRACE)) {
            return new TagContext(lbrace, identifier, current, slash);
          } else
            throw expectedType(TokenType.RBRACE);
        } else
          throw expectedType(TokenType.ID);
      } else
        throw expectedType(TokenType.SLASH);
    } else
      return null;
  }

  TagContextMember parseTagContextMember() =>
      parseAttribute() ?? (parseClassContext() ?? null);

  AttributeContext parseAttribute() {
    var identifier = parseIdentifier();
    if (identifier != null) {
      if (next(TokenType.EQUALS)) {
        var equals = current;
        var string = parseString();
        if (string != null)
          return new AttributeContext(identifier, equals, string);
        else
          throw expectedType(TokenType.STRING);
      } else
        throw expectedType(TokenType.EQUALS);
    } else
      return null;
  }

  ClassContext parseClassContext() {
    if (next(TokenType.DOT)) {
      var dot = current;
      var identifier = parseSimpleIdentifier();
      if (identifier != null)
        return new ClassContext(dot, identifier);
      else
        throw expectedType(TokenType.ID);
    } else
      return null;
  }

  IdentifierContext parseIdentifier() {
    var parent = parseSimpleIdentifier();
    if (parent != null) {
      var result = parent;

      while (next(TokenType.DOT)) {
        var dot = current;
        var child = parseSimpleIdentifier();
        if (child != null) {
          result = new IdentifierMemberContext(result, dot, child.ID);
        } else
          throw expectedType(TokenType.ID);
      }

      return result;
    } else
      return null;
  }

  IdentifierContext parseSimpleIdentifier() {
    if (next(TokenType.ID)) {
      return new IdentifierContext(current);
    } else
      return null;
  }

  StringContext parseString() =>
      next(TokenType.STRING) ? new StringContext(current) : null;

  TextContext parseText() =>
      next(TokenType.TEXT) ? new TextContext(current) : null;
}

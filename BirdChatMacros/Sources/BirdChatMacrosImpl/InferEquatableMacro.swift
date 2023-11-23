import SwiftSyntax
import SwiftSyntaxMacros

enum InferEquatableMacro: ExtensionMacro {
    
    static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        guard
            let memberName = node.arguments?.as(LabeledExprListSyntax.self)?.first?
                .expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
        else {
            throw BirdChatMacroError.unexpectedArguments
        }
        
        return [
            try ExtensionDeclSyntax("extension \(type.trimmed): Equatable") {
                try FunctionDeclSyntax("static func == (lhs: Self, rhs: Self) -> Bool") {
                    "lhs.\(literal: memberName) == rhs.\(literal: memberName)"
                }
            }
        ]
    }
    
}

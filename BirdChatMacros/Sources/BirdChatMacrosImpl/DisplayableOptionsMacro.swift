import SwiftSyntax
import SwiftSyntaxMacros

enum DisplayableOptionsMacro: DeclarationMacro {
    
    static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let arguments = node.argumentList
        guard arguments.count == 2 else {
            throw BirdChatMacroError.unexpectedArguments
        }
        
        guard 
            let typeName = arguments.first?.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue?
                .replacingOccurrences(of: " ", with: ""),
            let options = arguments.last?.expression.as(ArrayExprSyntax.self)?.elements
                .compactMap({ $0.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue })
        else {
            throw BirdChatMacroError.unexpectedArguments
        }
        
        guard !options.isEmpty else { throw Error.noOptions }
        
        let caseNames = options.map {
            ($0.prefix(1).lowercased() + $0.dropFirst())
                .replacingOccurrences(of: " ", with: "")
        }
        
        let casesDeclaration = caseNames
            .map { "case \($0)" }
            .joined(separator: "\n")
        
        let displayNameDeclaration = zip(caseNames, options)
            .map { "case .\($0): \"\($1)\"" }
            .joined(separator: "\n")
        
        return ["""
        enum \(raw: typeName) {
            
            \(raw: casesDeclaration)
            
            var displayName: String {
                switch self {
                \(raw: displayNameDeclaration)
                }
            }
            
        }
        """]
    }
    
}

extension DisplayableOptionsMacro {
    
    enum Error: Swift.Error, CustomStringConvertible {
        
        case noOptions
        
        var description: String {
            switch self {
            case .noOptions:
                "#DisplayableOptions expects at least one option"
            }
        }
        
    }
    
}

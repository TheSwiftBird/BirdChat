import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

enum TODOMacro: ExpressionMacro {
    
    static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard
            let comment = node.argumentList.first?.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
        else {
            throw BirdChatMacroError.unexpectedArguments
        }
        
        let message = TODODiagnosticMessage("TODO: \(comment)")
        
        let implementFixIt = FixIt(message: TODOFixItMessage("Implement now…"), changes: [
            .replace(oldNode: Syntax(node), newNode: Syntax(MissingSyntax(placeholder: "<#Implementation…#>")))
        ])
        let dismissFixIt = FixIt(message: TODOFixItMessage("Dismiss as not planned"), changes: [
            .replace(oldNode: Syntax(node), newNode: Syntax(StmtSyntax(stringLiteral: "")))
        ])
        
        let diagnostic = Diagnostic(node: node, message: message, fixIts: [implementFixIt, dismissFixIt])
        context.diagnose(diagnostic)
        
        return "\(raw: ())"
    }
    
}

extension TODOMacro {
    
    private struct TODODiagnosticMessage: DiagnosticMessage {
        
        let message: String
        let diagnosticID: MessageID
        let severity = DiagnosticSeverity.warning
        
        init(_ message: String) {
            self.message = message
            diagnosticID = MessageID(domain: "TODOMacro", id: "\(message.hashValue)")
        }
        
    }
    
    private struct TODOFixItMessage: FixItMessage {
        
        let message: String
        let fixItID: MessageID
        
        init(_ message: String) {
            self.message = message
            self.fixItID = MessageID(domain: "TODOMacro_FixIt", id: "\(message.hashValue)")
        }
        
    }
    
}

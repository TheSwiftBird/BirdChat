import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct BirdChatMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DisplayableOptionsMacro.self,
        InferEquatableMacro.self,
        StringifyMacro.self,
        TODOMacro.self,
    ]
}

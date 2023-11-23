@testable import BirdChatMacrosImpl

import SwiftSyntaxMacrosTestSupport
import XCTest

final class DisplayableOptionsMacroTests: XCTestCase {
    
    func testDisplayableOptions() {
        assertMacroExpansion(
            """
            #DisplayableOptions("SomeOptionSet", options: ["One", "Two", "Three"])
            """,
            expandedSource: """
            enum SomeOptionSet {
            
                case one
                case two
                case three
            
                var displayName: String {
                    switch self {
                    case .one:
                        "One"
                    case .two:
                        "Two"
                    case .three:
                        "Three"
                    }
                }
            
            }
            """,
            macros: testMacros
        )
    }
    
    func testDisplayableOptions_noOptions() {
        assertMacroExpansion(
            """
            #DisplayableOptions("EmptyOptionSet", options: [])
            """,
            expandedSource: """
            #DisplayableOptions("EmptyOptionSet", options: [])
            """,
            diagnostics: [DiagnosticSpec(
                message: "#DisplayableOptions expects at least one option",
                line: 1,
                column: 1
            )],
            macros: testMacros
        )
    }
    
    func testDisplayableOptions_whitespaces() {
        assertMacroExpansion(
            """
            #DisplayableOptions("Option Set With Whitespaces", options: ["Option One", "Option Two"]
            """,
            expandedSource: """
            enum OptionSetWithWhitespaces {
            
                case optionOne
                case optionTwo
            
                var displayName: String {
                    switch self {
                    case .optionOne:
                        "Option One"
                    case .optionTwo:
                        "Option Two"
                    }
                }
            
            }
            """,
            macros: testMacros
        )
    }
    
}

fileprivate let testMacros = [
    "DisplayableOptions": DisplayableOptionsMacro.self,
]

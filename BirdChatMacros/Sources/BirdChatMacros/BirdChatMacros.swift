// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "BirdChatMacrosImpl", type: "StringifyMacro")

@freestanding(declaration, names: arbitrary)
public macro DisplayableOptions(
    _ typeName: String,
    options: [String]
) = #externalMacro(module: "BirdChatMacrosImpl", type: "DisplayableOptionsMacro")

@attached(extension, conformances: Equatable, names: named(==))
public macro InferEquatable(basedOn memberName: String) = #externalMacro(module: "BirdChatMacrosImpl", type: "InferEquatableMacro")

@freestanding(expression)
public macro todo(_ comment: String) = #externalMacro(module: "BirdChatMacrosImpl", type: "TODOMacro")

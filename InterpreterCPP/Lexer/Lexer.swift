//
//  Lexer.swift
//  InterpreterCPlusPlus
//
//  Created by Maxim Butin on 16/11/2018.
//  Copyright © 2018 Maxim Butin. All rights reserved.
//

import Foundation


public class Lexer {
    
    private let text: String
    private var currentPosition: Int
    private var currentCharacter: Character?
    //private var isStringStart = false
    //private var wasStringLast = false
    
    private let keywords: [String: Token] = [
        "main": .main,
        "int": .type(.int),
        "bool": .type(.bool),
        "switch": .switch,
        "case": .case,
        "default": .default,
        "break": .break,
        "TRUE": .constant(.bool(true)),
        "FALSE": .constant(.bool(false))
    ]
    
    public init(_ text: String) {
        self.text = text
        currentPosition = 0
        currentCharacter = text.isEmpty ? nil : text[text.startIndex]
    }
    
    public func skipWhiteSpace() {
        while let character = currentCharacter, CharacterSet.whitespacesAndNewlines.contains(character.unicodeScalars.first!) {
            advance()
        }
    }
    
    public func skipComments() {
        while let character = currentCharacter, character != "\n"  {
            advance()
        }
        //advance()
    }
    
    public func advance() {
        currentPosition += 1
        guard currentPosition < text.count else {
            currentCharacter = nil
            return
        }
        currentCharacter = text[text.index(text.startIndex, offsetBy: currentPosition)]
        return
    }
    
    private func peek() -> Character? {
        let peekPosition = currentPosition + 1
        
        guard peekPosition < text.count else {
            return nil
        }
        
        return text[text.index(text.startIndex, offsetBy: peekPosition)]
    }
    
    private func number() -> Token {
        var lexem = ""
        let curChar = currentCharacter
        let curPos = currentPosition
        
        while let character = currentCharacter, CharacterSet.decimalDigits.contains(character.unicodeScalars.first!) {
            lexem += String(character)
            if lexem.count > 12 {
                while let character = currentCharacter, character != "\n"  {
                    advance()
                }
                //fatalError("Unrecognized character \(currentCharacter) at position \(currentPosition)")
                return .error(.longNumber(" \(curChar!) at position \(curPos) "))
            }
            advance()
        }
        
        return .constant(.int(Int(lexem)!))
    }
    
    private func hex() -> Token {
        var lexem = ""
        if let character = currentCharacter, character == "0" {
            advance()
            lexem += String(character)
            if let character = currentCharacter, (character == "x" || character == "X") {
                advance()
                lexem += String(character)
                while let character = currentCharacter, CharacterSet(charactersIn: "a"..."f").union(CharacterSet(charactersIn: "0"..."9")).union(CharacterSet(charactersIn: "A"..."F")).contains(character.unicodeScalars.first!) {
                    lexem += String(character)
                    advance()
                }
                
                return .constant(.hex(lexem)!)
            }
            
        }
        return .constant(.int(Int(lexem)!))
    }
    
    private func id() -> Token {
        var lexem = ""
        let curChar = currentCharacter
        let curPos = currentPosition
        
        while let character = currentCharacter, CharacterSet.alphanumerics.contains(character.unicodeScalars.first!) {
            lexem += String(character)
            if lexem.count >= 52 {
                while let character = currentCharacter, character != "\n"  {
                    advance()
                }
                //fatalError("Unrecognized character \(currentCharacter!) at position \(currentPosition)")
                return .error(.longId(" \(curChar!) at position \(curPos) "))
            }
            advance()
        }
        
        if let token = keywords[lexem] {
            return token
        }

        return .id(lexem)
    }
    
    public func getNextToken() -> Token {
        
        while let currentCharacter = currentCharacter {
            
            if CharacterSet.whitespacesAndNewlines.contains(currentCharacter.unicodeScalars.first!) {
                skipWhiteSpace()
                continue
            }
            
            if currentCharacter == "/" && peek() == "/" {
                advance()
                advance()
                skipComments()
                continue
            }
            
            if currentCharacter == "0" && (peek() == "x" || peek() == "X") {
                return hex()
            }
            
            if CharacterSet.decimalDigits.contains(currentCharacter.unicodeScalars.first!) {
                return number()
            }
            
            if CharacterSet(charactersIn: "A"..."Z").union(CharacterSet(charactersIn: "a"..."z")).contains(currentCharacter.unicodeScalars.first!) {
                return id()
            }
            
            if currentCharacter == "=" {
                advance()
                return .assign
            }
            
            if currentCharacter == "<" && peek() == "=" {
                advance()
                advance()
                return .lessEqual
            }
            
            if currentCharacter == ">" && peek() == "=" {
                advance()
                advance()
                return .greaterEqual
            }
            
            if currentCharacter == "!" {
                advance()
                return .not
            }
            
            if currentCharacter == "!" && peek() == "=" {
                advance()
                advance()
                return .notEqual
            }
            
            if currentCharacter == "|" && peek() == "|" {
                advance()
                advance()
                return .or
            }
            
            if currentCharacter == "&" && peek() == "&" {
                advance()
                advance()
                return .and
            }
            
            if currentCharacter == "," {
                advance()
                return .comma
            }
            
            if currentCharacter == "_" {
                advance()
                return .underscore
            }
            
            if currentCharacter == ";" {
                advance()
                return .semi
            }
            
            if currentCharacter == ":" {
                advance()
                return .colon
            }
            
            if currentCharacter == "+" {
                advance()
                return .operation(.plus)
            }
            
            if currentCharacter == "-" {
                advance()
                return .operation(.minus)
            }
            
            if currentCharacter == "*" {
                advance()
                return .operation(.multiply)
            }
            
            if currentCharacter == "/" {
                advance()
                return .operation(.divide)
            }
            
            if currentCharacter == "(" {
                advance()
                return .paren(.open)
            }
            
            if currentCharacter == ")" {
                advance()
                return .paren(.close)
            }
            
            if currentCharacter == "(" {
                advance()
                return .bracket(.open)
            }
            
            if currentCharacter == ")" {
                advance()
                return .bracket(.close)
            }
            
            if currentCharacter == ">" {
                advance()
                return .greaterThan
            }
            
            if currentCharacter == "<" {
                advance()
                return .lessThan
            }
            
            if currentCharacter == "{" {
                advance()
                return .bracket(.open)
            }
            
            if currentCharacter == "}" {
                advance()
                return .bracket(.close)
            }
                
            else {
                advance()
                return .error(.position("Unrecognized character \(currentCharacter) at position \(currentPosition)"))
                //fatalError("Unrecognized character \(currentCharacter) at position \(currentPosition)")
                //print("Unrecognized character \(currentCharacter) at position \(currentPosition)")
            }
        }
        return .eof
    }
}

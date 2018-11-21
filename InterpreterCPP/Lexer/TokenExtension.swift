//
//  TokenExtension.swift
//  InterpreterCPlusPlus
//
//  Created by Maxim Butin on 16/11/2018.
//  Copyright © 2018 Maxim Butin. All rights reserved.
//

import Foundation

extension Token: Equatable {
    public static func == (lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case let (.operation(left), .operation(right)):
            return left == right
        case let (.paren(left), .paren(right)):
            return left == right
        case let (.constant(left), .constant(right)):
            return left == right
        case let (.type(left), .type(right)):
            return left == right
        case let (.bracket(left), .bracket(right)):
            return left == right
        case let (.id(left), .id(right)):
            return left == right
        case (.error, .error):
            return true
        case (.main, .main):
            return true
        case (.assign, .assign):
            return true
        case (.mult_assign, .mult_assign):
            return true
        case (.div_assign, .div_assign):
            return true
        case (.plus_assign, .plus_assign):
            return true
        case (.min_assign, .min_assign):
            return true
        case (.colon, .colon):
            return true
        case (.greaterThan, .greaterThan):
            return true
        case (.lessThan, .lessThan):
            return true
        case (.comma, .comma):
            return true
        case (.equal, .equal):
            return true
        case (.greaterEqual, .greaterEqual):
            return true
        case (.lessEqual, .lessEqual):
            return true
        case (.notEqual, .notEqual):
            return true
        case (.or, .or):
            return true
        case (.not, .not):
            return true
        case (.and, .and):
            return true
        case (.switch, .switch):
            return true
        case (.default, .default):
            return true
        case (.break, .break):
            return true
        case (.return, .return):
            return true
        case (.eof, .eof):
            return true
        default:
            return false
        }
    }
}

extension Constant: Equatable {
    public static func == (lhs: Constant, rhs: Constant) -> Bool {
        switch(lhs, rhs) {
        case let (.int(left), int(right)):
            return left == right
        case let (.bool(left), .bool(right)):
            return left == right
        case let (.hex(left), .hex(right)): // ?
            return left == right
        default:
            return false
        }
    }
}

extension Operation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .plus:
            return "PLUS"
        case .minus:
            return "MINUS"
        case .divide:
            return "DIVIDE"
        case .multiply:
            return "MULTIPLY"
        }
    }
}

extension Type: CustomStringConvertible {
    public var description: String {
        switch self {
        case .bool:
            return "BOOL"
        case .int:
            return "INT"
        }
    }
}

extension Paren: CustomStringConvertible {
    public var description: String {
        switch self {
        case .open:
            return "OPEN_PAREN"
        case .close:
            return "CLOSE_PAREN"
        }
    }
}

extension Bracket: CustomStringConvertible {
    public var description: String {
        switch self {
        case .open:
            return "OPEN_BRACKET"
        case .close:
            return "CLOSE_BRACKET"
        }
    }
}

extension Constant: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .bool(value):
            return "BOOL_CONST(\(value))"
        case let .int(value):
            return "INT_CONST(\(value))"
        case let .hex(value):
            return "HEX_CONST(\(value))"
        }
    }
}

extension TokenError: CustomStringConvertible {
    public var description: String {
        switch self {
        case let  .longNumber(value):
            return "The number is long. The possible length should not exceed eight characters. \(value)"
        case let .longId(value):
            return "The id is long. The possible length should not exceed eight characters. \(value)"
        case let .position(value):
            return "Error in position. \(value)"
        }
    }
}

extension Token: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .operation(operation):
            return operation.description
        case let .paren(paren):
            return paren.description
        case let .constant(constant):
            return constant.description
        case let .type(type):
            return type.description
        case let .bracket(bracket):
            return bracket.description
        case let .id(value):
            return "ID(\(value))"
        case let .error(error):
            return error.description
        case .assign:
            return "ASSIGN"
        case .main:
            return "MAIN"
        case .mult_assign:
            return "MULT_ASSIGN"
        case .div_assign:
            return "DIV_ASSIGN"
        case .plus_assign:
            return "PLUS_ASSIGN"
        case .min_assign:
            return "MIN_ASSIGN"
        case .switch:
            return "SWITCH"
        case .default:
            return "DEFAULT"
        case .break:
            return "BREAK"
        case .case:
            return "CASE"
        case .return:
            return "RETURN"
        case .colon:
            return "COLON"
        case .greaterThan:
            return "GREATER_THAN"
        case .lessThan:
            return "LESS_THAN"
        case .notEqual:
            return "NOT_EQUAL"
        case .comma:
            return "COMMA"
        case .semi:
            return "SEMICOLON"
        case .equal:
            return "EQUAL"
        case .greaterEqual:
            return "GREATER_EQUAL"
        case .lessEqual:
            return "LESS_EQUAL"
        case .or:
            return "OR"
        case .underscore:
            return "UNDERSCORE"
        case .and:
            return "AND"
        case .not:
            return "NOT"
        case .eof:
            return "EOF"
        }
    }
}

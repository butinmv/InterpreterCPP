//
//  Token.swift
//  InterpreterCPlusPlus
//
//  Created by Maxim Butin on 16/11/2018.
//  Copyright © 2018 Maxim Butin. All rights reserved.
//

import Foundation


public enum Operation {
    case plus
    case minus
    case divide
    case multiply
}

// ()
public enum Paren {
    case open
    case close
}

// {}
public enum Bracket {
    case open
    case close
}

public enum Constant {
    case int(Int)
    case bool(Bool)
    case hex(String)
}

public enum Type {
    case int
    case bool
}

public enum TokenError {
    case longNumber(String)
    case longId(String)
    case position(String)
    //case unknown
}


public enum Token {
    case operation(Operation)
    case paren(Paren)
    case constant(Constant)
    case type(Type)
    case bracket(Bracket)
    case id(String)
    case assign
    case underscore
    case main
    case mult_assign
    case div_assign
    case plus_assign
    case min_assign
    case `switch`
    case `default`
    case `break`
    case `case`
    case `return`
    case colon
    case greaterThan
    case lessThan
    case comma
    case semi
    case equal
    case greaterEqual
    case lessEqual
    case notEqual
    case or
    case not
    case and
    case eof
    case error(TokenError)
}

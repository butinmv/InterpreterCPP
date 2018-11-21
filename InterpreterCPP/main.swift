//
//  main.swift
//  InterpreterCPlusPlus
//
//  Created by Maxim Butin on 20/11/2018.
//  Copyright © 2018 Maxim Butin. All rights reserved.
//

import Foundation

let file = File(nameFile: "code", nameExtension: "txt")
let code = file.readFile()
print(code)

let lexem = Lexer(code)

var token: Token
repeat {
    token = lexem.getNextToken()
    print(token)
} while (token != .eof)


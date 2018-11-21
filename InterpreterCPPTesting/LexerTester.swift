//
//  LexerTester.swift
//  InterpreterCPPTesting
//
//  Created by Maxim Butin on 20/11/2018.
//  Copyright © 2018 Maxim Butin. All rights reserved.
//


import XCTest
import Foundation

//TODO: Расширить тестирование

class LexerTester: XCTestCase {

    func testEmptyInput() {
        let codeInput = ""
        let lexer = Lexer(codeInput)
        let eof = lexer.getNextToken()
        XCTAssert(eof == .eof)
    }
    
    func testWhitespaceOnlyInput() {
        let codeInput = " "
        let lexer = Lexer(codeInput)
        let eof = lexer.getNextToken()
        XCTAssert(eof == .eof)
    }
    
    func testInt() {
        let codeInput = "1213"
        let lexer = Lexer(codeInput)
        let int = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(int == .constant(.int(1213)))
        XCTAssert(eof == .eof)
    }
    
    func testHex() {
        let codeInput = "0xfa"
        let lexer = Lexer(codeInput)
        let hex = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(hex == .constant(.hex("0xfa")))
        XCTAssert(eof == .eof)
    }
    
    func testBool() {
        let codeInput = "TRUE FALSE"
        let lexer = Lexer(codeInput)
        let true_const = lexer.getNextToken()
        let false_const = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(true_const == .constant(.bool(true)))
        XCTAssert(false_const == .constant(.bool(false)))
        XCTAssert(eof == .eof)
    }
    
    func testIntegerPlusInteger() {
        let codeInput = "3+4"
        let lexer = Lexer(codeInput)
        let left = lexer.getNextToken()
        let operation = lexer.getNextToken()
        let right = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(left == .constant(.int(3)))
        XCTAssert(operation == .operation(.plus))
        XCTAssert(right == .constant(.int(4)))
        XCTAssert(eof == .eof)
    }
    
    func testIntegerMinusInteger() {
        let codeInput = "3-4"
        let lexer = Lexer(codeInput)
        let left = lexer.getNextToken()
        let operation = lexer.getNextToken()
        let right = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(left == .constant(.int(3)))
        XCTAssert(operation == .operation(.minus))
        XCTAssert(right == .constant(.int(4)))
        XCTAssert(eof == .eof)
    }
    
    func testIntegerMultiplyInteger() {
        let codeInput = "3*4"
        let lexer = Lexer(codeInput)
        let left = lexer.getNextToken()
        let operation = lexer.getNextToken()
        let right = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(left == .constant(.int(3)))
        XCTAssert(operation == .operation(.multiply))
        XCTAssert(right == .constant(.int(4)))
        XCTAssert(eof == .eof)
    }
    
    func testIntegerDivideInteger() {
        let codeInput = "3/4"
        let lexer = Lexer(codeInput)
        let left = lexer.getNextToken()
        let operation = lexer.getNextToken()
        let right = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(left == .constant(.int(3)))
        XCTAssert(operation == .operation(.divide))
        XCTAssert(right == .constant(.int(4)))
        XCTAssert(eof == .eof)
    }
    
    func testIntegerPlusIntegerWithWhiteSace3() {
        let codeInput = " 3 + 4"
        let lexer = Lexer(codeInput)
        let left = lexer.getNextToken()
        let operation = lexer.getNextToken()
        let right = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(left == .constant(.int(3)))
        XCTAssert(operation == .operation(.plus))
        XCTAssert(right == .constant(.int(4)))
        XCTAssert(eof == .eof)
    }
    
    func testIntegerPlusIntegerWithWhiteSace4() {
        let codeInput = "3+ 4 "
        let lexer = Lexer(codeInput)
        let left = lexer.getNextToken()
        let operation = lexer.getNextToken()
        let right = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(left == .constant(.int(3)))
        XCTAssert(operation == .operation(.plus))
        XCTAssert(right == .constant(.int(4)))
        XCTAssert(eof == .eof)
    }
    
    func testMultiDigitStrings() {
        let codeInput = " 13+ 154 "
        let lexer = Lexer(codeInput)
        let left = lexer.getNextToken()
        let operation = lexer.getNextToken()
        let right = lexer.getNextToken()
        let eof = lexer.getNextToken()
        
        XCTAssert(left == .constant(.int(13)))
        XCTAssert(operation == .operation(.plus))
        XCTAssert(right == .constant(.int(154)))
        XCTAssert(eof == .eof)
    }
    
    func testParentheses() {
        let codeInput = "(1+(3*5))"
        let lexer = Lexer(codeInput)
        
        XCTAssert(lexer.getNextToken() == .paren(.open))
        XCTAssert(lexer.getNextToken() == .constant(.int(1)))
        XCTAssert(lexer.getNextToken() == .operation(.plus))
        XCTAssert(lexer.getNextToken() == .paren(.open))
        XCTAssert(lexer.getNextToken() == .constant(.int(3)))
        XCTAssert(lexer.getNextToken() == .operation(.multiply))
        XCTAssert(lexer.getNextToken() == .constant(.int(5)))
        XCTAssert(lexer.getNextToken() == .paren(.close))
        XCTAssert(lexer.getNextToken() == .paren(.close))
        XCTAssert(lexer.getNextToken() == .eof)
    }
    
    func testComment() {
        let codeInput = "//sdfasdfsadhfkhsldf"
        let lexer = Lexer(codeInput)
        
        XCTAssert(lexer.getNextToken() == .eof)
    }
    
    func testAssignmentAndComment() {
        let codeInput = "a = 2 // a = 5 "
        let lexer = Lexer(codeInput)
        
        XCTAssert(lexer.getNextToken() == .id("a"))
        XCTAssert(lexer.getNextToken() == .assign)
        XCTAssert(lexer.getNextToken() == .constant(.int(2)))
        XCTAssert(lexer.getNextToken() == .eof)
    }
    
    func testCommentAndAssignment() {
        let codeInput = """
                            //a = 2
                            a = 5
                        """
        let lexer = Lexer(codeInput)
        
        XCTAssert(lexer.getNextToken() == .id("a"))
        XCTAssert(lexer.getNextToken() == .assign)
        XCTAssert(lexer.getNextToken() == .constant(.int(5)))
        XCTAssert(lexer.getNextToken() == .eof)
    }
    
    func testParsingError() {
        let codeInput = "8 + |"
        let lexer = Lexer(codeInput)
        
        XCTAssert(lexer.getNextToken() == .constant(.int(8)))
        XCTAssert(lexer.getNextToken() == .operation(.plus))
        XCTAssert(lexer.getNextToken() == .error(.position("Unrecognized character | at position 5")))
        XCTAssert(lexer.getNextToken() == .eof)
        //expectFatalError(expectedMessage: "Unrecognized character | at position 5") {
        //    _ = lexer.getNextToken()
    }
}
    


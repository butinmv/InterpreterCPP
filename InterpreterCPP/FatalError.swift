//
//  FatalError.swift
//  InterpreterCPP
//
//  Created by Maxim Butin on 21/11/2018.
//  Copyright © 2018 Maxim Butin. All rights reserved.
//

import Foundation

/**
 Taken from https://medium.com/@marcosantadev/how-to-test-fatalerror-in-swift-e1be9ff11a29
 */

func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

struct FatalErrorUtil {
    
    // 1
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    // 2
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    // 3
    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    
    // 4
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}

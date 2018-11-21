//
//  XCTestCase+FatalError.swift
//  InterpreterCPPTesting
//
//  Created by Maxim Butin on 20/11/2018.
//  Copyright © 2018 Maxim Butin. All rights reserved.
//

import XCTest
import InterpreterCPlusPlus
import Foundation

extension XCTestCase {
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String?
        
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            
            FatalErrorUtil.restoreFatalError()
        }
    }
    
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while true
    }
}

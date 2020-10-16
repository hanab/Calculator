//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Hana  Demas on 10/15/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest

class CalculatorUITests: XCTestCase {

    //MARK: methods
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    //MATK: testcases
    func testPlus() {
        let app = XCUIApplication()
        
        app.buttons["8"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        
        XCTAssert(app.staticTexts["14.0"].exists)
    }
    
    func testSubtraction() {
        let app = XCUIApplication()
        
        app.buttons["8"].tap()
        app.buttons["-"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        
        XCTAssert(app.staticTexts["2.0"].exists)
    }
    
    func testMultiply() {
        let app = XCUIApplication()
        
        app.buttons["7"].tap()
        app.buttons["x"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        
        XCTAssert(app.staticTexts["63.0"].exists)
    }
    
    func testDivision() {
        let app = XCUIApplication()
        
        app.buttons["2"].tap()
        app.buttons["5"].tap()
        app.buttons["/"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        XCTAssert(app.staticTexts["5.0"].exists)
    }
    
    func testReminder() {
        let app = XCUIApplication()
               
        app.buttons["2"].tap()
        app.buttons["5"].tap()
        app.buttons["5"].tap()
        app.buttons["%"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        
        XCTAssert(app.staticTexts["0.0"].exists)
    }
    
    func testChangeSign() {
        let app = XCUIApplication()
               
        app.buttons["2"].tap()
        app.buttons["5"].tap()
        app.buttons["5"].tap()
        app.buttons["+/-"].tap()
        app.buttons["="].tap()
        
        XCTAssert(app.staticTexts["-255.0"].exists)
    }
}


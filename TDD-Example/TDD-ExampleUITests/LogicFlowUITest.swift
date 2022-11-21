//
//  LogicFlowUITest.swift
//  TDD-ExampleUITests
//
//  Created by 순진이 on 2022/11/21.
//

import XCTest


//test를 붙이면 마름모가 뜸
final class LogicFlowUITest: XCTestCase {
    
    private var app: XCUIApplication!
    private var idTextField: XCUIElement!
    private var pwTextField: XCUIElement!
    private var loginButton: XCUIElement!

    
    
    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
        idTextField = app.textFields["idTextField"]
        pwTextField = app.textFields["pwTextField"]
        loginButton = app.buttons["loginButton"]
    }

    override func tearDownWithError() throws {
        
    }
    
    func testLoginSuccess() throws {
        let app = XCUIApplication()
        app.textFields["idTextField"].tap()
        app.textFields["idTextField"].typeText("Admin")
        app.textFields["pwTextField"].tap()
        app.textFields["pwTextField"].typeText("Admin")
        loginButton.tap()
    }
    
    

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

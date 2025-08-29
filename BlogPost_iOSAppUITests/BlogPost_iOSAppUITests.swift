//
//  BlogPost_iOSAppUITests.swift
//  BlogPost_iOSAppUITests
//
//  Created by Shuvo Joseph on 25/8/25.
//

import XCTest

final class BlogPost_iOSAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
  
    func testLogoutAndLoginFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        //print("app.debugDescription : " + app.debugDescription)
        // Step 1: Check if we're on Dashboard and determine current login state
        let dashboardNavBar = app.navigationBars["Dashboard"]
        XCTAssertTrue(dashboardNavBar.waitForExistence(timeout: 10), "Dashboard not visible")

        // Check if logout button exists (means we're logged in)
        let logoutButton = dashboardNavBar.buttons["Logout"]
        let loginButton = dashboardNavBar.buttons["Login"]
        
        if logoutButton.exists && logoutButton.isHittable {
            // Scenario 1: Already logged in - need to logout first
            print("Already logged in - proceeding with logout then login")
            
            // Step 2: Tap Logout
            logoutButton.tap()
            
            // Wait for logout to complete (UI should update to show Login button)
            XCTAssertTrue(loginButton.waitForExistence(timeout: 10), "Login button not visible after logout")
            
            // Now proceed to login
            performLogin(app: app)
            
        } else if loginButton.exists && loginButton.isHittable {
            // Scenario 2: Already logged out - just login directly
            print("Already logged out - proceeding with login directly")
            performLogin(app: app)
        } else {
            XCTFail("Unexpected state: Neither Logout nor Login button is visible")
        }

        // Final verification: Dashboard should be visible after successful login
        XCTAssertTrue(dashboardNavBar.waitForExistence(timeout: 10), "Dashboard not visible after login")
    }

    // Helper function to perform the login process
    private func performLogin(app: XCUIApplication) {
        // Tap the Login button in navigation bar
        let loginNavButton = app.navigationBars["Dashboard"].buttons["Login"]
        XCTAssertTrue(loginNavButton.waitForExistence(timeout: 10), "Navigation Login button not found")
        loginNavButton.tap()
        
        // Wait for login sheet to appear and fill credentials
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginFormButton = app.buttons["loginButton"]
        
        XCTAssertTrue(emailField.waitForExistence(timeout: 10), "Email field not found in login sheet")
        XCTAssertTrue(passwordField.waitForExistence(timeout: 10), "Password field not found in login sheet")
        XCTAssertTrue(loginFormButton.waitForExistence(timeout: 10), "Login button not found in login sheet")
        
        // Fill login form
        emailField.tap()
        emailField.typeText("ios24@deshiit.com")
        
        passwordField.tap()
        passwordField.typeText("ios1234")
        
        // Tap login button and wait for sheet to dismiss
        loginFormButton.tap()
        
        // Wait briefly for the login process to complete and sheet to dismiss
        let loginSheetDismissed = loginFormButton.waitForNonExistence(timeout: 10)
        XCTAssertTrue(loginSheetDismissed, "Login sheet should have dismissed after successful login")
    }

    // Helper extension to wait for element to disappear
    func waitForNonExistence(timeout: TimeInterval) -> Bool {
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: self
        )
        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed
    }
}

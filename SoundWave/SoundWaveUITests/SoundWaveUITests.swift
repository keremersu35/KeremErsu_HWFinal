//
//  SoundWaveUITests.swift
//  SoundWaveUITests
//
//  Created by Kerem Ersu on 7.06.2023.
//

import XCTest

final class SoundWaveUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("******** UITest ********")
    }
    
    func test_search_for_api_request() {
        app.launch()
        
        XCTAssertTrue(app.isSearchTextFieldDisplayed)
        
        app.searchTextField.tap()
        app.searchTextField.typeText("Simge")
        app.keyboards.buttons["Return"].tap()
        
        XCTAssertEqual(app.searchTextField.value as? String, "Simge")
    }
    
    func test_navigate_to_detail_page() {
        app.launch()
        
        XCTAssertTrue(app.isSearchTextFieldDisplayed)
        
        app.searchTextField.tap()
        app.searchTextField.typeText("Simge")
        app.keyboards.buttons["Return"].tap()
        
        XCTAssertEqual(app.searchTextField.value as? String, "Simge")
        
        if (app.tables.element(boundBy: 0).cells.count > 0) {
            app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
            
            XCTAssertTrue(app.isDetailPlayButtonDisplayed)
            app.playButton.tap()
            let delayExpectation = XCTestExpectation()
            delayExpectation.isInverted = true
            wait(for: [delayExpectation], timeout: 5)
            
        }
    }
    
    func test_navigate_to_favorite_detail_page() {
        app.launch()
        
        XCTAssertTrue(app.isSearchTextFieldDisplayed)
        app.navBarFavoriteButton.tap()
        
        //Favorilerde şarkı yoksa favori sayfasından sonra test kapanacaktır.
        if (app.tables.element(boundBy: 0).cells.count > 0) {
            app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
            
            XCTAssertTrue(app.isDetailPlayButtonDisplayed)
            app.playButton.tap()
            let delayExpectation = XCTestExpectation()
            delayExpectation.isInverted = true
            wait(for: [delayExpectation], timeout: 5)
        }
    }
}

extension XCUIApplication {
    
    var searchTextField: XCUIElement! {
        textFields["searchTextField"]
    }
    
    var playButton: XCUIElement! {
        buttons["playButton"]
    }
    
    var navBarFavoriteButton: XCUIElement! {
        buttons["navBarFavoriteButton"]
    }
    
    var isSearchTextFieldDisplayed: Bool {
        searchTextField.exists
    }
    
    var isDetailPlayButtonDisplayed: Bool {
        playButton.exists
    }
    
    var isNavBarFavoriteButtonDisplayed: Bool {
        navBarFavoriteButton.exists
    }
}

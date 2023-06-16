//
//  HomePresenterTests.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import XCTest
@testable import SoundWave

final class HomePresenterTests: XCTestCase {

    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!
    
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }
    
    func test_viewDidLoad_InvokesRequiredViewMethods() {
        
        XCTAssertFalse(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 0)
        XCTAssertFalse(view.isInvokedSetTitle)
        XCTAssertNil(view.invokedSetTitleParameters)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 1)
        XCTAssertTrue(view.isInvokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "SoundWave")
    }
    
    func test_fetchTracksOutput() {
        
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertFalse(view.isInvokedReloadData)
        
        presenter.fetchTracksOutput(.success(.response))
        
        XCTAssertTrue(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItems(), 50)
        XCTAssertTrue(view.isInvokedReloadData)
    }
}

extension Tracks {
    
    static var response: Tracks {
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "Tracks", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(Tracks.self, from: data)
        return response
    }
}

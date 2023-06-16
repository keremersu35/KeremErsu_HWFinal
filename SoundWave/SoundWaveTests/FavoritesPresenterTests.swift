//
//  FavoritesPresenterTests.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import XCTest
@testable import SoundWave

final class FavoritesPresenterTests: XCTestCase {

    var presenter: FavoritesPresenter!
    var view: MockFavoritesViewController!
    var interactor: MockFavoriteInteractor!
    var router: MockFavoriteRouter!
    
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
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "Favorites")
        
    }
    
    func test_getAllFavorites_InvokesRequiredViewMethods() {
        
        XCTAssertFalse(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(view.invokedShowLoadingCount, 0)
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertEqual(view.invokedHideLoadingCount, 0)
        
        presenter.getAllFavorites()
        
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertTrue(view.isInvokedShowLoading)
        XCTAssertEqual(view.invokedShowLoadingCount, 1)
        XCTAssertTrue(view.isInvokedHideLoading)
        XCTAssertEqual(view.invokedHideLoadingCount, 1)
    }
}

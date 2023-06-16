//
//  DetailPresenterTests.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import XCTest
@testable import SoundWave

final class DetailPresenterTests: XCTestCase {

    var presenter: DetailPresenter!
    var view: MockDetailViewController!
    var interactor: MockDetailInteractor!
    var router: MockDetailRouter!
    var track: Track?
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, interactor: interactor, router: router)
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }

    func test_viewDidLoad_InvokesRequiredViewMethods() {
        
        XCTAssertFalse(view.isInvokedSetImage)
        XCTAssertFalse(view.isInvokedSetTitle)
        XCTAssertFalse(view.isInvokedSetTrackName)
        XCTAssertFalse(view.isInvokedSetAlbumName)
        XCTAssertFalse(view.isInvokedSetArtistName)
        XCTAssertNil(view.invokedSetImageParameters)
        XCTAssertNil(view.invokedSetTitleParameters)
        XCTAssertNil(view.invokedSetAlbumNameParameters)
        XCTAssertNil(view.invokedSetTrackNameParameters)
        XCTAssertNil(view.invokedSetArtistNameParameters)
        
        presenter.viewDidLoad()
        
        //XCTAssertTrue(view.isInvokedSetImage)
        XCTAssertTrue(view.isInvokedSetTitle)
        XCTAssertTrue(view.isInvokedSetTrackName)
        XCTAssertTrue(view.isInvokedSetAlbumName)
        XCTAssertTrue(view.isInvokedSetArtistName)
        XCTAssertEqual(view.invokedSetImageParameters?.image, nil)
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "Aşkın Olayım")
        XCTAssertEqual(view.invokedSetAlbumNameParameters?.name, "Ben Bazen")
        XCTAssertEqual(view.invokedSetTrackNameParameters?.name, "Aşkın Olayım")
        XCTAssertEqual(view.invokedSetArtistNameParameters?.name, "Simge")
        
    }
    
    func test_viewWillAppear_InvokesRequiredViewMethods() {
        
        XCTAssertFalse(view.isInvokedCheckFavorite)
        
        presenter.viewWillAppear()
        
        XCTAssertTrue(view.isInvokedCheckFavorite)
    }
    
    func test_playButtonTapped_InvokesRequiredViewMethods() {
        
        XCTAssertFalse(view.isInvokedPlayButtonTapped)
        
        presenter.playButtonTapped()
        
        XCTAssertTrue(view.isInvokedPlayButtonTapped)
    }
    
    func test_favoriteButtonTapped_InvokesRequiredViewMethods() {
        
        XCTAssertFalse(view.isInvokedFavoriteButtonTapped)
        
        presenter.favoriteButtonTapped()
        
        XCTAssertTrue(view.isInvokedFavoriteButtonTapped)
    }
}

//
//  TrackCellPresenterTests.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import XCTest
@testable import SoundWave

final class TrackCellPresenterTests: XCTestCase {

    var view: MockTrackCell!
    var track: Track!
    var presenter: TrackCellPresenter!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        
        let track = TrackCellModel(
            trackName: "Final Homework",
            artistName: "Kerem Ersu",
            imageUrl: "",
            previewUrl: ""
        )
        
        presenter = .init(view: view, track: track)
    }

    override func tearDown() {
        view = nil
        presenter = nil
    }
    
    func test_load() {
        
        XCTAssertFalse(view.isInvokedSetTrackImageView)
        XCTAssertFalse(view.isInvokedSetTrackNameLabel)
        XCTAssertFalse(view.isInvokedSetArtistNameLabel)
        XCTAssertFalse(view.isInvokedCheckIsPlaying)
        XCTAssertFalse(view.isInvokedSetIsPlayingAsFalse)
        XCTAssertFalse(view.isInvokedSetButtonImageAsPlay)
        XCTAssertNil(view.invokedSetTrackImageViewParameters)
        XCTAssertNil(view.invokedSetTrackNameLabelParameters)
        XCTAssertNil(view.invokedSetArtistNameLabelParameters)
        
        presenter.setup()
        
        //XCTAssertTrue(view.isInvokedSetTrackImageView)
        XCTAssertTrue(view.isInvokedSetTrackNameLabel)
        XCTAssertTrue(view.isInvokedSetArtistNameLabel)
        XCTAssertFalse(view.isInvokedCheckIsPlaying)
        XCTAssertFalse(view.isInvokedSetIsPlayingAsFalse)
        XCTAssertFalse(view.isInvokedSetButtonImageAsPlay)
        XCTAssertEqual(view.invokedSetTrackImageViewParameters?.image, nil)
        XCTAssertEqual(view.invokedSetTrackNameLabelParameters?.text, "Final Homework")
        XCTAssertEqual(view.invokedSetArtistNameLabelParameters?.text, "Kerem Ersu")
        
    }
}

//
//  DetailInteractor.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//


import Foundation

//Detay sayfasında veri çekilmeyecekse bu protocol tanımlanmayabilir
protocol DetailInteractorProtocol {
    
}

protocol DetailInteractorOutputProtocol {
    func fetchNewsDetailOutput(result: TracksSourcesResult)
}

final class DetailInteractor {
    var output: HomeInteractorOutputProtocol?
}

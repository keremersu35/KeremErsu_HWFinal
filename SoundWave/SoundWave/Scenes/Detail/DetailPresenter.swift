//
//  DetailPresenter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import UIKit

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func tapSeeMore()
}

extension DetailPresenter {
    fileprivate enum Constants {
        static let pageTitle: String = "Detail"
    }
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol!
    let router: DetailRouterProtocol!
    
    init(
        view: DetailViewControllerProtocol,
        router: DetailRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
    
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func viewDidLoad() {
    
//        guard let news = view.getSource() else { return }
//        
//        ImageDownloader.shared.image(
//            news: news,
//            format: .superJumbo)
//        { [weak self] data, error in
//            guard let self else { return }
//            guard let data, error == nil else { return }
//            guard let image = UIImage(data: data) else { return }
//            self.view.setNewsImage(image)
//        }
//        
//        
//        view.setTitle(Constants.pageTitle)
//        view.setNewsTitle(news.title ?? "")
//        view.setNewsDetail(news.abstract ?? "")
//        view.setNewsAuthor(news.byline ?? "")
    }
    
    func tapSeeMore() {
//        guard let urlString = view.getSource()?.url else { return }
//        guard let url = URL(string: urlString) else { return }
//        router.navigate(.openURL(url: url))
    }
    
}

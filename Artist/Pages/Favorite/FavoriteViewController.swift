//
//  FavoriteViewController.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/20.
//

import Foundation
import UIKit
class FavoriteViewController: BaseCollectionViewController {
    
    lazy var topStackView = TopStackView(delegate: self.viewModel)
    
    var viewModel: FavoriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = .init(hex: "F4F4F4")
        self.regisCell()
        
        self.addTopStackView()
        self.resetCollectionView()
        self.viewModel = .init(delegate: self, adapter: self.adapter)
        self.viewModel?.setupRow()
        self.viewModel?.setupTopStackViewModel()
    }
    
    func regisCell() {
        
        let ids = ["StackScrollCell", "TitleSubTitleCell", "TitleCell"]
        
        for id in ids {
            
            self.collectionView.register(.init(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
        }

    }
    
    func addTopStackView() {
        self.view.addSubview(self.topStackView)
        
        NSLayoutConstraint.activate([
            self.topStackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.topStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func resetCollectionView() {
        self.collectionView.removeFromSuperview()
        
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topStackView.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    

}

extension FavoriteViewController: FavoriteViewMethod {
    func topStackViewModelDidSet(viewModel: TopStackViewModel?) {
        self.topStackView.updateView(viewModel: viewModel)
    }
}

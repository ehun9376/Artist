//
//  HomeViewController.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/20.
//

import Foundation
import UIKit
import SwiftRichString
class HomeViewController: BaseCollectionViewController {
    
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = .init(hex: "F4F4F4")
        self.regisCell()

        self.viewModel = .init(delegate: self, adapter: self.adapter)
        self.viewModel?.setupRow()

    }
    
    func regisCell() {
        
        let ids = ["StackScrollCell", "TitleSubTitleCell", "TitleCell"]
        
        for id in ids {
            
            self.collectionView.register(.init(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
        }

    }
    
    

}

extension HomeViewController: HomeViewMethod {
    func cellDidSelect() {
        
    }
}

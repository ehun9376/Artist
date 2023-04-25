//
//  FavoriteViewModel.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/25.
//

import Foundation
import UIKit

protocol FavoriteViewMethod {
    func topStackViewModelDidSet(viewModel: TopStackViewModel?)
}

class FavoriteViewModel {
    
    var delegate: FavoriteViewMethod?
    
    var adapter: CollectionViewAdapter?
    
    var topStackViewModel: TopStackViewModel? {
        didSet {
            self.delegate?.topStackViewModelDidSet(viewModel: self.topStackViewModel)
        }
    }
    
    init(delegate: FavoriteViewMethod? = nil, adapter: CollectionViewAdapter?) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRow() {
        
        var itemModels: [CollectionItemModel] = []

        let itemModel = TitleSubTitleItemModel(title: "創世紀",
                                               subTitle: "李奧納多・達文西，1508\n3654 x 1314 cm",
                                               imageName: "newAge",
                                               favorite: true,
                                               imageAxis: .hori,
                                               itemSize: .init(width: UIScreen.main.bounds.width, height: 150))
        itemModel.cellDidPressed = { _ in
        }
        
        itemModel.favorButtonAction = { favor in
            itemModel.favorite = favor
        }
        
        itemModels.append(itemModel)
        itemModels.append(itemModel)
        itemModels.append(itemModel)
        itemModels.append(itemModel)
        itemModels.append(itemModel)
        itemModels.append(itemModel)
        self.adapter?.updateData(itemModels: itemModels)
    }
    
    func setupTopStackViewModel() {
        self.topStackViewModel = TopStackViewModel(tags: [.art, .artSpace, .artist])
    }
    
}

extension FavoriteViewModel: TopStackViewMethod {
    func topStackViewButtonAction(tag: FavoriteTag) {
        
    }
}

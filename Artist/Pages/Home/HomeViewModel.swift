//
//  HomeViewModel.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/21.
//

import Foundation
import UIKit

protocol HomeViewMethod {
    func cellDidSelect()
}

class HomeViewModel: NSObject {
    
    var delegate: HomeViewMethod?
    
    var adapter: CollectionViewAdapter?
    
    init(delegate: HomeViewMethod? = nil, adapter: CollectionViewAdapter?) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRow() {
        var itemModels: [CollectionItemModel] = []
        
        let hotItem = TitleCellItemModel(title: "今日熱門展覽",
                                         itemSize: .init(width: UIScreen.main.bounds.width, height: 50),
                                         itemDidSelectAction: nil)
        
        
        itemModels.append(hotItem)
        
        let itemModel = TitleSubTitleItemModel(title: "會移動的文藝復興",
                                               subTitle: "文藝復興是14世紀至16世紀在歐洲興起的一場有關藝術、文學、自然科學和建築等各方面的思想文化運動，該時期的作品，體現了人文主義思想：主張",
                                               imageName: "monnaLisa",
                                               favorite: true,
                                               itemSize: .init(width: UIScreen.main.bounds.width, height: 180))
        itemModel.cellDidPressed = { _ in
            self.delegate?.cellDidSelect()
        }
        
        itemModel.favorButtonAction = { favor in
            itemModel.favorite = favor
        }
        
        itemModels.append(itemModel)
        
        let selectItem = TitleCellItemModel(title: "選擇一個類別展覽",
                                            itemSize: .init(width: UIScreen.main.bounds.width, height: 50),
                                            itemDidSelectAction: nil)
        
        itemModels.append(selectItem)
        
        let buttonsItem = StackScrollCellItemModel(buttonTagTypes: [.artist, .africaArtist, .artWork, .chineseArtist, .europeArtist, .femaleArtist, .africaArtist],
                                                   buttonAction: { _ in
            
        },
                                                   itemSize: .init(width: UIScreen.main.bounds.width, height: 30),
                                                   itemDidSelectAction: { _ in
            
        })

        
        itemModels.append(buttonsItem)
        
        self.adapter?.updateData(itemModels: itemModels)
    }
    
}

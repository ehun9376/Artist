//
//  TItleCell.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/21.
//

import Foundation
import UIKit

class TitleCellItemModel: CollectionItemModel {
    override func cellReUseID() -> String {
        return "TitleCell"
    }
    
    var title: String?
    
    init(title: String?,
         itemSize: CGSize? = nil,
         itemDidSelectAction: ((CollectionItemModel?) -> ())? = nil)
    {
        super.init()
        self.title = title
        self.itemSize = itemSize
        self.cellDidPressed = itemDidSelectAction
    }
}

class TitleCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        self.titleLabel.font = .interBold(size: 18)
        self.titleLabel.textColor = .init(hex: "494949")
    }
}

extension TitleCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let itemModel = model as? TitleCellItemModel else { return }
        self.titleLabel.text = itemModel.title
    }
}


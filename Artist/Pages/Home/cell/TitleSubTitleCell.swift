//
//  TitleSubTitleCell.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/21.
//

import Foundation
import UIKit

class TitleSubTitleItemModel: CollectionItemModel {
    
    enum ImageAxis {
        case hori
        case vertical
    }
    
    override func cellReUseID() -> String {
        return "TitleSubTitleCell"
    }
    
    var title: String?
    
    var subTitle: String?
        
    var imageName: String?
    
    var favorite: Bool = false
    
    var imageAxis: ImageAxis = .hori
    
    var favorButtonAction: ((_ favorite: Bool)->())?

    init(
        title: String? = nil,
        subTitle: String? = nil,
        imageName: String? = nil,
        favorite: Bool = false,
        imageAxis: ImageAxis = .vertical,
        itemSize: CGSize,
        favorButtonAction: ((_ favorite: Bool)->())? = nil,
        cellDidPressed: ((CollectionItemModel?) -> ())? = nil
    ) {
        super.init()
        self.title = title
        self.subTitle = subTitle
        self.imageName = imageName
        self.favorite = favorite
        self.imageAxis = imageAxis
        self.itemSize = itemSize
        self.favorButtonAction = favorButtonAction
        self.cellDidPressed = cellDidPressed
    }
}

class TitleSubTitleCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var aspect: NSLayoutConstraint!
    
    var itemModel: TitleSubTitleItemModel?
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        
        self.backView.layer.cornerRadius = 10
        
        self.titleLabel.font = .interBold(size: 16)
//        self.titleLabel.adjustsFontSizeToFitWidth = true
        
        self.subTitleLabel.font = .interRegular(size: 14)
        self.subTitleLabel.numberOfLines = 4
        self.subTitleLabel.lineBreakMode = .byTruncatingTail
        self.subTitleLabel.textColor = .init(hex: "797979")
//        self.subTitleLabel.adjustsFontSizeToFitWidth = true
        
        self.favoriteButton.configuration = nil
        self.favoriteButton.tintColor = nil
        self.favoriteButton.setTitle(nil, for: .normal)
        self.favoriteButton.setTitle(nil, for: .selected)
        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonAction(_:)), for: .touchUpInside)
        self.favoriteButton.setImage(.init(named: "heartEmpty")?.resizeImage(targetSize: .init(width: 20, height: 20)), for: .normal)
        self.favoriteButton.setImage(.init(named: "heartFill")?.resizeImage(targetSize: .init(width: 20, height: 20)), for: .selected)
        
        self.rightImageView.contentMode = .scaleToFill
        
        
    }
    
    @objc func favoriteButtonAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.itemModel?.favorButtonAction?(sender.isSelected)
    }

}

extension TitleSubTitleCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let itemModel = model as? TitleSubTitleItemModel else { return }
        self.itemModel = itemModel
        
        self.titleLabel.text = itemModel.title
        self.subTitleLabel.text = itemModel.subTitle
        self.rightImageView.image = UIImage(named: itemModel.imageName ?? "")
        self.favoriteButton.isSelected = itemModel.favorite
        
//        self.aspect.multiplier = itemModel.imageAxis == .hori ? 524/436 : 485/600

        self.rightImageView.constraints.forEach { constraint in
            if constraint.firstAttribute == .width && constraint.secondAttribute == .height {
                // 將aspect比率修改為2:1
                constraint.isActive = false
                self.rightImageView.widthAnchor.constraint(equalTo: self.rightImageView.heightAnchor, multiplier: itemModel.imageAxis == .hori ? 524/436 : 485/600).isActive = true
            }
        }
    }
}

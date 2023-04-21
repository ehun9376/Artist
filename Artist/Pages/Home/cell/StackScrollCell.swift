//
//  StackScrollCell.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/21.
//

import Foundation
import UIKit

enum TagType: Int, CaseIterable {
    
    case artWork = 0
    case artist = 1
    case femaleArtist = 2
    case europeArtist = 3
    case chineseArtist = 4
    case africaArtist = 5
    
    var title: String {
        switch self {
        case .artWork:
            return "藝術作品"
        case .artist:
            return "藝術家"
        case .femaleArtist:
            return "女性藝術家"
        case .europeArtist:
            return "歐洲藝術"
        case .chineseArtist:
            return "中國藝術"
        case .africaArtist:
            return "非洲藝術"
        }
    }
}



class StackScrollCellItemModel: CollectionItemModel {

    override func cellReUseID() -> String {
        return "StackScrollCell"
    }
    
    var buttonTagTypes: [TagType] = []
    
    var buttonAction: ((TagType)->())?
    
    init(
        buttonTagTypes: [TagType] = [],
        buttonAction: ((TagType)->())?,
        itemSize: CGSize? = nil,
        itemDidSelectAction: ((CollectionItemModel?) -> ())? = nil)
    {
        super.init(itemSize: itemSize, itemDidSelectAction: itemDidSelectAction)
        self.buttonTagTypes = buttonTagTypes
        self.buttonAction = buttonAction
    }
    
}


class StackScrollCell: UICollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var stackView = UIStackView()
    
    var itemModel: StackScrollCellItemModel?
    
    
    override func awakeFromNib() {

        
        self.scrollView.addSubview(self.stackView)

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.stackView.axis = .horizontal
        self.stackView.alignment = .center
        self.stackView.distribution = .equalSpacing
    }
    
    func creatButton(type: TagType) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = nil
        button.setTitle(type.title, for: .normal)
        button.tintColor = nil
        button.backgroundColor = .init(hex: "CF504A")
        button.tag = type.rawValue
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return button
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        if let type = TagType(rawValue: sender.tag) {
            self.itemModel?.buttonAction?(type)
        }
        
        
    }
    
}

extension StackScrollCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let itemModel = model as? StackScrollCellItemModel else { return }
        self.itemModel = itemModel
        for type in itemModel.buttonTagTypes {
            self.stackView.addArrangedSubview(self.creatButton(type: type))
        }
        
    }
}

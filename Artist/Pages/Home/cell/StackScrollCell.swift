//
//  StackScrollCell.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/21.
//

import Foundation
import UIKit

enum TagType: Int, CaseIterable {
    
    case artWork = 1
    case artist = 2
    case femaleArtist = 4
    case europeArtist = 8
    case chineseArtist = 16
    case africaArtist = 32
    
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
    
    var selectedTagTypes: [TagType] = []
    
    var buttonAction: ((TagType)->())?
    
    init(
        buttonTagTypes: [TagType] = [],
        selectedTagTypes: [TagType] = [],
        buttonAction: ((TagType)->())?,
        itemSize: CGSize? = nil,
        itemDidSelectAction: ((CollectionItemModel?) -> ())? = nil)
    {
        super.init(itemSize: itemSize, itemDidSelectAction: itemDidSelectAction)
        self.buttonTagTypes = buttonTagTypes
        self.selectedTagTypes = selectedTagTypes
        self.buttonAction = buttonAction
    }
    
}


class StackScrollCell: UICollectionViewCell {
    
    var scrollView = UIScrollView()
    
    var stackView = UIStackView()
    
    var itemModel: StackScrollCellItemModel?
    
    
    override func awakeFromNib() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.scrollView)
        
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.stackView)
        self.stackView.axis = .horizontal
        self.stackView.alignment = .center
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 20
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 30),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -30)

        ])
    }
    
    func creatButton(type: TagType, seletedType: [TagType]) -> UIButton {
        let button = UIButton(type: .custom)
        button.configuration = nil
        button.setTitle(" #\(type.title) ", for: .normal)
        button.setTitleColor(.init(hex: "FFFFFF"), for: .normal)
        button.setTitleColor(.init(hex: "CDCDCD"), for: .selected)
        button.titleLabel?.font = .interBold(size: 16)
        button.tintColor = nil
        button.backgroundColor = .init(hex: "CF504A")
        button.tag = type.rawValue
        button.layer.cornerRadius = 8
        button.isSelected = seletedType.contains(type)
        button.contentEdgeInsets = .init(top: 8, left: 10, bottom: 8, right: 10)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        
        
        if let type = TagType(rawValue: sender.tag) {
            self.itemModel?.buttonAction?(type)
            sender.isSelected.toggle()
        }
    }
    
}

extension StackScrollCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let itemModel = model as? StackScrollCellItemModel else { return }
        self.itemModel = itemModel
        for view in self.stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        for type in itemModel.buttonTagTypes {
            self.stackView.addArrangedSubview(self.creatButton(type: type, seletedType: self.itemModel?.selectedTagTypes ?? []))
        }
        
    }
}


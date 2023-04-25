//
//  TopStackScrollView.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/25.
//

import Foundation
import UIKit

enum FavoriteTag: Int, CaseIterable {
    case art = 1
    case artSpace = 2
    case artist = 4

    var title: String {
        switch self {
        case .art:
            return "藝術作品"
        case .artSpace:
            return "展覽空間"
        case .artist:
            return "藝術家"
        }
    }

}

protocol TopStackViewMethod {
    func topStackViewButtonAction(tag: FavoriteTag)
}

class TopStackViewModel {
    var tags: [FavoriteTag] = []
    
    var defaultTag: FavoriteTag = .art
    
    init(
        tags: [FavoriteTag] = [],
        defaultTag: FavoriteTag = .art
    ) {
        self.tags = tags
        self.defaultTag = defaultTag
    }
}

class TopStackView: UIView {
    
    lazy var stackView = self.creatStackView()
    
    var delegate: TopStackViewMethod?
    
    var viewModel: TopStackViewModel?
    
    
    convenience init(
        delegate: TopStackViewMethod?
    ) {
        self.init()
        self.delegate = delegate
        self.setupView()
    }
    
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .init(hex: "F4F4F4")

        
        self.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13),
        ])
  
    }
    
    func updateView(viewModel: TopStackViewModel?) {
        
        self.viewModel = viewModel
        
        for view in self.stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        for tag in self.viewModel?.tags ?? [] {
            self.stackView.addArrangedSubview(self.creatButton(type: tag, defaultTag: self.viewModel?.defaultTag ?? .art))
        }
    }
    
    func creatStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        return stackView
    }
    
    func creatButton(type: FavoriteTag, defaultTag: FavoriteTag) -> UIButton {
        let button = UIButton(type: .custom)
        button.configuration = nil
        button.isEnabled = type != defaultTag
        button.setTitle("\(type.title)", for: .normal)
        button.setTitleColor(.init(hex: "FFFFFF"), for: .normal)
        button.setTitleColor(.init(hex: "FFFFFF"), for: .disabled)
        button.backgroundColor = button.isEnabled ? .init(hex: "CF504A") : .init(hex: "CF504A").withAlphaComponent(0.7)
        button.titleLabel?.font = .interBold(size: 14)
        button.tintColor = nil
        button.tag = type.rawValue
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        button.isEnabled = type != defaultTag
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        
        for view in self.stackView.arrangedSubviews {
            if let button = view as? UIButton {
                button.isEnabled = true
                button.backgroundColor = .init(hex: "CF504A")
            }
        }
        
        if let type = FavoriteTag(rawValue: sender.tag) {
            self.delegate?.topStackViewButtonAction(tag: type)
            sender.isEnabled = false
            sender.backgroundColor = .init(hex: "CF504A").withAlphaComponent(0.7)
        }
    }
    
}

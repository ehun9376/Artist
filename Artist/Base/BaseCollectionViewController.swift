//
//  BaseCollectionViewController.swift
//  TintTint
//
//  Created by yihuang on 2022/10/20.
//

import Foundation
import UIKit

public class BaseCollectionViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: creatLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var adapter: CollectionViewAdapter?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAdapter()
        self.addCollectionView()
    }
    
    func creatLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    func setupAdapter() {
        self.adapter = .init(collectionView: self.collectionView)
        self.adapter?.lastCellDidDisplay = { [weak self] page in
            guard let self = self else { return }
            self.lastCellWillDisplay(page: page)
        }
    }
    
    func addCollectionView() {
        
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        
    }
    
    func lastCellWillDisplay(page:Int){ }
    
}

//
//  ViewController.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import UIKit


class RootViewController: UIViewController {
    
    lazy var homePageViewController: HomePageViewController = {
        let pageViewController = HomePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return pageViewController
    }()
    
    lazy var bottmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.bottmStackView.addArrangedSubview(self.creatBottomButton(title: "首頁", imageName: "homeIcon", tag: 0))
        self.bottmStackView.addArrangedSubview(self.creatBottomButton(title: "我的收藏", imageName: "favoriteIcon", tag: 1))
        self.bottmStackView.addArrangedSubview(self.creatBottomButton(title: "我的展間", imageName: "myRoomIcon", tag: 2))
        self.bottmStackView.addArrangedSubview(self.creatBottomButton(title: "我的帳戶", imageName: "accountIcon", tag: 3))
        
        for view in self.bottmStackView.arrangedSubviews {
            if let button = view as? UIButton {
                if button.tag == 0 {
                    button.isSelected = true
                }
            }
        }
        
        self.view.addSubview(self.bottmStackView)
        NSLayoutConstraint.activate([
            self.bottmStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.bottmStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.bottmStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
            
        self.view.addSubview(self.homePageViewController.view)
        self.homePageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homePageViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            homePageViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            homePageViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            homePageViewController.view.bottomAnchor.constraint(equalTo: self.bottmStackView.topAnchor)
        ])
        
    }
    

    
    private func creatBottomButton(title: String, imageName: String, tag: Int) -> UIButton {
        let button = TopImageButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.tag = tag

        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setImage(.init(named: imageName), for: .normal)
        button.setImage(.init(named: imageName+"Red"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(bottomButtonAction(_:)), for: .touchUpInside)

 
        return button
    }
    
    @objc func bottomButtonAction(_ sender: UIButton) {
        for view in self.bottmStackView.arrangedSubviews {
            if let button = view as? UIButton {
                if button.tag == sender.tag {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
        }
        self.homePageViewController.setPage(index: sender.tag)
    }
    
    
}


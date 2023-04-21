//
//  ViewController.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import UIKit
import SwiftRichString


class RootViewController: UIViewController {
    
    lazy var homePageViewController: HomePageViewController = {
        let pageViewController = HomePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return pageViewController
    }()
    
    lazy var lineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var shortLineView: UIView = {
        let view = UIView(frame: .init(x: 0, y: UIScreen.main.bounds.maxY-100, width: 0, height: 0))
        view.backgroundColor = .red
        view.layer.cornerRadius = 1
        view.clipsToBounds = true
        view.frame.size.height = 5
        return view
    }()
    
    lazy var spaceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
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
        self.addAllSubVIews()
        self.setNavigation(navigationC: self.navigationController, item: self.navigationItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setSliderView(tag: 0)
    }
    
    func addAllSubVIews() {
        
        self.lineStackView.addArrangedSubview(self.createSliderView(tag: 0))
        self.lineStackView.addArrangedSubview(self.createSliderView(tag: 1))
        self.lineStackView.addArrangedSubview(self.createSliderView(tag: 2))
        self.lineStackView.addArrangedSubview(self.createSliderView(tag: 3))
        
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
        
        self.view.addSubview(self.spaceView)
        NSLayoutConstraint.activate([
            self.spaceView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.spaceView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.spaceView.bottomAnchor.constraint(equalTo: self.bottmStackView.topAnchor),
            self.spaceView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        self.view.addSubview(self.lineStackView)
        NSLayoutConstraint.activate([
            self.lineStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.lineStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.lineStackView.bottomAnchor.constraint(equalTo: self.spaceView.topAnchor),
            self.lineStackView.heightAnchor.constraint(equalToConstant: 0.8)
        ])
            
        self.view.addSubview(self.homePageViewController.view)
        self.homePageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.homePageViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.homePageViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.homePageViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.homePageViewController.view.bottomAnchor.constraint(equalTo: self.lineStackView.topAnchor)
        ])
        
        self.view.addSubview(self.shortLineView)
    }
    

    
    private func creatBottomButton(title: String, imageName: String, tag: Int) -> UIButton {
        let button = TopImageButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.tag = tag

        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setImage(.init(named: imageName)?.resizeImage(targetSize: .init(width: 50, height: 50)), for: .normal)
        button.setImage(.init(named: imageName+"Red")?.resizeImage(targetSize: .init(width: 50, height: 50)), for: .selected)
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
        
        self.setSliderView(tag: sender.tag)
        self.homePageViewController.setPage(index: sender.tag)
    }
    
    func createSliderView(tag: Int) -> UIView {
        let view = UIView()
        var frame = view.frame
        frame.size.height = 0.8
        view.frame = frame
        view.tag = tag
        view.backgroundColor = .black
        return view
    }
    
    func setSliderView(tag: Int) {
        UIView.animate(withDuration: 0.2) {
            for view in self.lineStackView.arrangedSubviews {
                if view.tag == tag {
                    var frame = self.lineStackView.frame
                    frame.size.width = UIScreen.main.bounds.width/4
                    frame.size.height = 2
                    frame.origin.x = frame.size.width*CGFloat(tag)
                    frame.origin.y = frame.origin.y - 1
                    self.shortLineView.frame = frame
                }
                
            }
           
        }

    }
    
    
    func setNavigation(navigationC: UINavigationController?, item: UINavigationItem?) {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        
        navigationC?.navigationBar.standardAppearance = appearance
        navigationC?.navigationBar.scrollEdgeAppearance = appearance
        
        let label = UILabel()
        
        let style1 = Style {
            $0.color = Color.red
            $0.font = UIFont.adventProRegular(size: 18)
        }
        
        let defaultStyle = Style {
            $0.color = Color.black
            $0.font = UIFont.adventProRegular(size: 18)
        }
        
        let att = AttributedString.composing {
            "I".set(style: style1)
            "maginary".set(style: defaultStyle)
            " E".set(style: style1)
            "xhibition".set(style: defaultStyle)
        }
        label.attributedText = att


        self.navigationItem.titleView = label
        
        let spaceBarButtonItem = UIBarButtonItem()
        spaceBarButtonItem.width = 20
        
        let spaceBarButtonItem2 = UIBarButtonItem()
        spaceBarButtonItem2.width = 25
        
        let scope: UIBarButtonItem = .init(customView: UIImageView.init(image: .init(named: "scope")?.resizeImage(targetSize: .init(width: 30, height: 30))))
        item?.leftBarButtonItems = [spaceBarButtonItem, scope]
        
        let bell: UIBarButtonItem = .init(customView: UIImageView.init(image: .init(named: "bell")?.resizeImage(targetSize: .init(width: 30, height: 30))))
        item?.rightBarButtonItems = [spaceBarButtonItem2, bell]
    }
    
    
    
    
}



//
//  ViewController.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/20.
//

import UIKit
import SwiftRichString

class HomePageViewController: UIPageViewController {
    
    var viewControllerList: [UIViewController] = []
    
    var nowPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllerList = [
            HomeViewController(),
            FavoriteViewController(),
            MyRoomViewController(),
            MyAccountViewController()
        ]
        
        
        self.setPage(index: 0)
        
        
    }
    
    
    public func setPage(index: Int) {
        if let vc = self.viewControllerList[safe: index] {
            self.setViewControllers([vc], direction: index > self.nowPage ? .forward : .reverse, animated: true)
            self.nowPage = index
        }
    }

    
}

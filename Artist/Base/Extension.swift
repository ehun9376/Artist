//
//  Extension.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/23.
//

import Foundation
import UIKit
import AudioToolbox
import AVFoundation

class TopImageButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            if var titleLabelFrame = titleLabel?.frame, var imageViewFrame = imageView?.frame {
                
                var baseGap: CGFloat = 8.0
                var hGap: CGFloat = baseGap
                var imageNewHeight: CGFloat = self.frame.height * 0.33
                var labelNewHeight: CGFloat = self.frame.height * 0.25
                var topGap: CGFloat = self.frame.height - baseGap * 2 - imageNewHeight - labelNewHeight
                
                if self.frame.width < hGap * 2 {
                    hGap = 0
                }
                if self.frame.height < (baseGap * 3 + imageNewHeight + labelNewHeight) {
                    baseGap = 0.0
                    topGap = 2.0
                    imageNewHeight = self.frame.height / 2 - 2
                    labelNewHeight = self.frame.height / 2 - 2
                }
                let width = self.frame.width - hGap * 2

                imageViewFrame.origin.x = hGap
                imageViewFrame.origin.y = topGap
                imageViewFrame.size = CGSize(width: width, height: imageNewHeight)

                titleLabelFrame.origin.x = hGap
                titleLabelFrame.origin.y = topGap + imageNewHeight + baseGap
                titleLabelFrame.size = CGSize(width: width, height: labelNewHeight)

                self.titleLabel?.textAlignment = .center
                self.titleLabel?.frame = titleLabelFrame
                self.imageView?.frame = imageViewFrame

//                let gap: CGFloat = 4.0
//                let height = (self.frame.height - gap * 2) / 2
//                imageViewFrame.origin.x = gap
//                imageViewFrame.origin.y = gap
//                imageViewFrame.size = CGSize(width: width, height: height)
//
//                titleLabelFrame.origin.x = gap
//                titleLabelFrame.origin.y = gap + height
//                titleLabelFrame.size = CGSize(width: width, height: height)
//                self.titleLabel?.textAlignment = .center
//                self.titleLabel?.frame = titleLabelFrame
//                self.imageView?.frame = imageViewFrame
            }
        } else {
            if var titleLabelFrame = titleLabel?.frame {
                var gap = (self.frame.size.width - titleLabelFrame.size.width) / 2
                if gap < 0 {
                    gap = (self.frame.size.width - titleLabelFrame.size.width) / 2
                }
                titleLabelFrame.origin.x = gap
                
                self.titleLabel?.frame = titleLabelFrame
            }
        }
    }
}
enum SessionSetupResult {
    case success
    case notAuthorized
    case configurationFailed
}

public extension Array {
    subscript(safe index: Int) -> Element? {
        return (0 <= index && index < count) ? self[index] : nil
    }
}

extension UIView {
    
    public func drawSingleSideBoder(top: Bool = false, bottom: Bool = false, left: Bool = false, right: Bool = false, width: CGFloat, borderColor: UIColor){
        if top {
            let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
            self.draw(rect)
        }
        
        if bottom {
            let rect = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: width)
            self.draw(rect)
            
        }
        
        if left {
            let rect = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
            self.draw(rect)
            
        }
        
        if right {
            let rect = CGRect(x: self.frame.size.width - width, y:0 , width: width, height: self.frame.size.height)
            self.draw(rect)
        }
        
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension UIImageView {
    
    func setImageFromURL(urlText: String) {
        DispatchQueue.global().async {
            guard let url = URL(string: urlText) else { return }
            let request = URLRequest(url: url, timeoutInterval: 30)
            
            URLSession.shared.dataTask(with: request) { [weak self] data, respond, error in
                if let data = data , let image = UIImage(data: data) {
                    self?.image = image
                }
            }
        }
    }
}

extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
      let rect = CGRect(origin: .zero, size: size)
      UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
      color.setFill()
      UIRectFill(rect)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      guard let cgImage = image?.cgImage else { return nil }
      self.init(cgImage: cgImage)
    }
    
    func resize(targetSize: CGSize, isAspect: Bool = true) -> UIImage {
        var newSize: CGSize = targetSize
        if isAspect {
            // Figure out what our orientation is, and use that to form the rectangle
            let widthRatio  = targetSize.width  / self.size.width
            let heightRatio = targetSize.height / self.size.height
            
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 10.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
extension NSObject {
    
    func systemVibration(sender: AnyObject, complete: (()->())?) {
        AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), complete)
    }
    
    func sendLocalNotication(title: String? = nil, subTitle: String? = nil, body: String? = nil) {
        
        let content = UNMutableNotificationContent()
        content.title = title ?? ""
        content.subtitle = subTitle ?? ""
        content.body = body ?? ""
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            
        }
    }
}

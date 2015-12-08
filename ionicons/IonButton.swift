//
//  IonButton.swift
//  Example-ionicons
//
//  Created by Max Campolo on 12/8/15.
//  Copyright © 2015 Max Campolo. All rights reserved.
//

import UIKit

@IBDesignable
class IonButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Other stuff
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable var ionIconBackgroundImage: String? {
        get {
            return self.currentBackgroundImage?.description
        }
        set {
            self.setBackgroundImage(IonIcons.imageWithIcon(self.convertToUnicode(newValue!), size: self.frame.size.width, color: .blackColor()).imageWithRenderingMode(.AlwaysTemplate), forState:UIControlState.Normal)
        }
    }
    
    @IBInspectable var ionIconImage: String? {
        get {
            return self.currentImage?.description
        }
        set {
            self.setImage(IonIcons.imageWithIcon(self.convertToUnicode(newValue!), size: self.frame.size.width, color: .blackColor()).imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        }
    }
    
    func convertToUnicode(hexString: String) -> String? {
        var result: String?
        let scanner = NSScanner(string: hexString)
        var unicodeInt = UInt32()
        if scanner.scanHexInt(&unicodeInt) {
            if let unicodeString: NSString = NSString(bytes: &unicodeInt, length: 4, encoding: NSUTF32LittleEndianStringEncoding) {
                result = unicodeString as String
            }
        }
        return result
    }

}

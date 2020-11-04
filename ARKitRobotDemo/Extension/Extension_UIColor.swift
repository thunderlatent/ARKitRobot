//
//  Extension_UIColor.swift
//  ARKitRobotDemo
//
//  Created by 陳裕銘 on 2019/10/21.
//  Copyright © 2019 yuming. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
        
    }
}

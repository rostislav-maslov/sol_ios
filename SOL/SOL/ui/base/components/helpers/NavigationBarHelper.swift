//
//  NavigationBarHelper.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.09.2021.
//

import Foundation
import UIKit

public class NavigationBarHelper {
    public static var heightDelta:CGFloat = 0.0
    
    static func updateHeightDelta(){
        print("==============")
        print("NavigationBarHelper")
        print("")
        print("")
        print("")
        print("\(Device().type)")
        print("")
        print("")
        print("")
        print("==============")
        self.heightDelta = 0.0
        
        switch Device().type {
        case  .iPhoneX,
              .iPhoneXS,
              .iPhoneXSMax,
              .iPhoneXR,
              .iPhone11,
              .iPhone11Pro,
              .iPhone11ProMax,
              
              .iPhone12Mini,
              .iPhone12,
              .iPhone12Pro,
              .iPhone12ProMax:
            heightDelta = 14.0
            
        case  .iPhone4,
              .iPhone4S,
              .iPhone5,
              .iPhone5S,
              .iPhone5C,
              .iPhone6,
              .iPhone6Plus,
              .iPhone6S,
              .iPhone6SPlus,
              .iPhoneSE,
              .iPhoneSE2,
              .iPhone7,
              .iPhone7Plus,
              .iPhone8,
              .iPhone8Plus:
            heightDelta = 0.0
        default: break
        }
    }
    
    
}

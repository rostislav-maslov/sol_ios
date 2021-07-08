//
//  TaskLineColors.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.05.2021.
//

import Foundation
import SwiftUI

class TaskLine {
    var backgroundLevel1: Color
    var backgroundLevel2: Color
    var backgroundLevel3: Color
    var backgroundLevel4: Color
    var shadow: Color
    
    init( backgroundLevel1: Color,
     backgroundLevel2: Color,
     backgroundLevel3: Color,
     backgroundLevel4: Color,
     shadow: Color) {
        self.backgroundLevel1 = backgroundLevel1
        self.backgroundLevel2 = backgroundLevel2
        self.backgroundLevel3 = backgroundLevel3
        self.backgroundLevel4 = backgroundLevel4
        self.shadow = shadow
    }
    
    func background(level: Int) -> Color {
        if level == 1 {
            return backgroundLevel1
        }
        if level == 2 {
            return backgroundLevel2
        }
        if level == 3 {
            return backgroundLevel3
        }
        return backgroundLevel4
    }
}

class TaskLineColors{
    
    static func colors() -> TaskLine {
        //        if( UIScreen.main.traitCollection.userInterfaceStyle == .light ) { return lightColors() }
        //        return darkColors()
        return lightColors()
    }
    
    static func lightColors() -> TaskLine {
        let colors: TaskLine = TaskLine(
            backgroundLevel1: Color(CGColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)),
            backgroundLevel2: Color(CGColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)),
            backgroundLevel3: Color(CGColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)),
            backgroundLevel4: Color(CGColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)),
            shadow: Color(CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2))
        )
        
        return colors
    }
    
    //    static func darkColors() -> ColorsVar {
    //        let colors: ColorsVar = ColorsVar(background: Color.white, buttonBackground: Color.white, storiesGradient: Color.white, fontColors: FontColors(normal: Color.white, second: Color.white))
    //
    //        return colors
    //    }
    
}

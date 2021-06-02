//
//  SolColor.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.05.2021.
//

import Foundation
import SwiftUI

struct FontColors {
    var normal: Color
    var second: Color
}

struct TextFieldColors {
    var login: Color
}

struct ScreenColors{
    var background: Color
}

struct ColorsVar {
    var fontColors: FontColors
    var textField: TextFieldColors
    var button: ButtonColors
    var screen: ScreenColors
}

struct ButtonColors {
    var background: Color
    var backgroundLoading: Color
    var font: Color
}

class SolColor{
    
    static func colors() -> ColorsVar {
        //        if( UIScreen.main.traitCollection.userInterfaceStyle == .light ) { return lightColors() }
        //        return darkColors()
        return lightColors()
    }
    
    static func lightColors() -> ColorsVar {
        let colors: ColorsVar = ColorsVar(
            fontColors: FontColors(
                normal: Color(CGColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)),
                second: Color(CGColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1))
            ),
            textField: TextFieldColors(
                login: Color(CGColor(red: 248/255, green: 249/255, blue: 255/255, alpha: 1))
            ),
            button: ButtonColors(
                background: Color(CGColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)),
                backgroundLoading: Color(CGColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 0.6)),
                font: Color(CGColor(red: 243/255, green: 244/255, blue: 256/255, alpha: 1))
            ),
            
            screen: ScreenColors(background: Color(CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
        )
        return colors
    }
    
    //    static func darkColors() -> ColorsVar {
    //        let colors: ColorsVar = ColorsVar(background: Color.white, buttonBackground: Color.white, storiesGradient: Color.white, fontColors: FontColors(normal: Color.white, second: Color.white))
    //
    //        return colors
    //    }
    
}

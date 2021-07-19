//
//  SolColor.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.05.2021.
//

import Foundation
import SwiftUI

struct ColorsVar {
    var fontColors: FontColors
    var textField: TextFieldColors
    var button: ButtonColors
    var screen: ScreenColors
    var addTask: AddTask
    var checkBox: CheckBox
    var actionButton:ActionButton
}

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

struct ButtonColors {
    var background: Color
    var backgroundLoading: Color
    var font: Color
}

struct AddTask{
    var placeholderBackground: Color
    var placeholderTextDefault: Color
    var placeholderTextFill: Color
    var addTaskBackground: Color
    var taskButtonDefaultColor: Color
    var taskButtonActiveColor: Color
}

struct CheckBox{
    var undoneBackground: Color
    var doneBackground: Color
}

struct ActionButton {
    var background: Color
    var taskDone: Color
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
            
            screen: ScreenColors(background: Color(CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1))),
            
            addTask: AddTask(
                placeholderBackground: Color(CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)),
                placeholderTextDefault: Color(CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)),
                placeholderTextFill: .white,
                addTaskBackground: Color(CGColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)),
                taskButtonDefaultColor: Color(CGColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)),
                taskButtonActiveColor: Color(CGColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0))
            ),
            
            checkBox: CheckBox(
                undoneBackground: Color(CGColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)),
                doneBackground: Color(CGColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 0.5))
            ),
            
            actionButton: ActionButton(
                background: Color(red: 246/255,green: 246/255,blue: 246/255),
                taskDone: Color(red:28/255, green: 206/255, blue: 12/255)
            )
        )
        return colors
    }
    
    //    static func darkColors() -> ColorsVar {
    //        let colors: ColorsVar = ColorsVar(background: Color.white, buttonBackground: Color.white, storiesGradient: Color.white, fontColors: FontColors(normal: Color.white, second: Color.white))
    //
    //        return colors
    //    }
    
}

//
//  NavigationBarColor.swift
//  SOL
//
//  Created by Rostislav Maslov on 27.04.2021.
//

import Foundation
import SwiftUI

struct NavigationBarItemBackModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        UINavigationBar.appearance().tintColor = UIColor.red
    }
    
    func body(content: Content) -> some View {
       content
    }
}

extension View {
 
    func navigationBarColor(_ color: UIColor?) -> some View {
        self.modifier(NavigationBarItemBackModifier(backgroundColor: color))
    }

}

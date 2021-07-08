//
//  SOLApp.swift
//  SOL
//
//  Created by Rostislav Maslov on 20.04.2021.
//

import SwiftUI

@main
struct SOLApp: App {
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                Color(CGColor(
                    red:239/255, green:239/255, blue: 239/255, alpha:1
                    
                )).ignoresSafeArea(.all)
                AppLoadingView()                
            }
            .statusBar(hidden: false)
            
            .preferredColorScheme(.light)
        }
        
    }
}

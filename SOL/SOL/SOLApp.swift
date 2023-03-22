//
//  SOLApp.swift
//  SOL
//
//  Created by Rostislav Maslov on 20.04.2021.
//

import SwiftUI
import ArmSdk

@main
struct SOLApp: App {
    
    init() {
        ArmSDK.start(
            armURL: "http://service.analytics.marketing.ftl-dev.ru",
            app: "SOL_APP",
            appVersion: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
        получение дип сылок
        получение уведомлений
        
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

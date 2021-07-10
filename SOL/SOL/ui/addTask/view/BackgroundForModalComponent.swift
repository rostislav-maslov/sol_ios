//
//  BackgroundForModalComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.06.2021.
//

import SwiftUI

struct BackgroundView: View {
    var didTouch: () -> Void
    var body: some View {
        Button(action: didTouch, label: {
            Rectangle()
                .frame(width: .infinity, height: .infinity, alignment: .center)
                .foregroundColor(Color(CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)))
                .ignoresSafeArea()
        })
        
    }
}


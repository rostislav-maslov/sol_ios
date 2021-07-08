//
//  IconComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.05.2021.
//

import SwiftUI

struct IconComponent: View {
    var size:CGFloat = 23
    var icon: String
    
    var body: some View {
        Text(icon)
            .font(.system(size: self.size))
           // .frame(width: 21, height: 21, alignment: .center)
        
            .preferredColorScheme(.light)
    }
}

struct IconComponent_Previews: PreviewProvider {
    static var previews: some View {
        IconComponent(size: 32, icon: "🥳")
    }
}

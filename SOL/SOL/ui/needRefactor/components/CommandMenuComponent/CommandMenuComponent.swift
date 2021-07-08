//
//  CommandMenuComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

struct CommandMenuComponent: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                VStack {
                    Spacer()
                        .frame(width: 5, height: 10, alignment: .center)
                }
                VStack {
                    CompandComponent()
                    CompandComponent()
                }
                VStack {
                    CompandComponent()
                    CompandComponent()
                }
                VStack {
                    CompandComponent()
                    CompandComponent()
                }
                VStack {
                    Spacer()
                        .frame(width: 10, height: 10, alignment: .center)
                }
                
            }
        }
        
    }
}

struct CommandMenuComponent_Previews: PreviewProvider {
    static var previews: some View {
        CommandMenuComponent()
            .preferredColorScheme(.light)
    }
}

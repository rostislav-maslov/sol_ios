//
//  SpaceItemComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

struct SpaceItemComponent: View {
    var icon: String
    var title: String
    var body: some View {
        VStack{
            Spacer().frame(width: 1, height: 12, alignment: .center)
            HStack{
                Spacer()
                    .frame(width: 19, height: 1, alignment: .center)
                Text(icon)
                    .font(.system(size: 16))
                Spacer()
                    .frame(width: 6, height: 1, alignment: .center)
                Text(title)
                    .font(.system(size: 16))
                Spacer()
            }
            Spacer().frame(width: 1, height: 12, alignment: .center)
        }
    }
}

struct SpaceItemComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpaceItemComponent(icon: "🦐", title: "Space name")
            .preferredColorScheme(.light)
    }
}

//
//  TLCheckBoxComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.05.2021.
//

import SwiftUI

struct TLCheckBoxComponent: View {
    var body: some View {
        VStack{
            Spacer().frame(width: 0, height: 3, alignment: .center)
            Image("checkbox")
                .foregroundColor(.blue)
                .frame(width: 14, height: 14, alignment: .center)
        }
    }
}

struct TLCheckBoxComponent_Previews: PreviewProvider {
    static var previews: some View {
        TLCheckBoxComponent()
    }
}

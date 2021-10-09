//
//  SpacesViewContent.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.09.2021.
//

import Foundation
import SwiftUI


extension SpacesView {
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer()
                .frame(width: 1, height: 41+16, alignment: .center)
            mainInfo
            spacesList
            Spacer()
                .frame(width: 1, height: 142, alignment: .center)
            addSpaceSheet
        }
        .background(SolColor.colors().screen.background)
        .ignoresSafeArea(.all)
    }
}

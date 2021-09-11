//
//  SpaceViewHeader.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI
import NavigationStack

extension SpaceView {
    var header: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            headerSpacer
            taskTitle
            Spacer().frame(width: 1, height: .infinity, alignment: .center)
        })
    }
}

extension SpaceView {
    var headerSpacer: some View {
        HStack{
            Spacer()
                .frame(
                    width: .infinity,
                    height: (41 + 41 + CGFloat(NavigationBarHelper.heightDelta)),
                    alignment: .center)
        }
    }
}

//struct SpaceHeaderView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        SpaceView(model: SpaceViewModel.forRender())
//    }
//}


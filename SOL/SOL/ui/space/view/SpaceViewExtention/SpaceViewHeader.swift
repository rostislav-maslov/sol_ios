//
//  SpaceViewHeader.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI


extension SpaceView {
    var header: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            taskTitle
        })
    }
}

extension SpaceView {
    var headerSpacer: some View {
        HStack{
            Spacer()
                .frame(                    
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


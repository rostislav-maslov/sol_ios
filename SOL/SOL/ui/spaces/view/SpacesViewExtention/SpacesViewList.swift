//
//  SpacesViewList.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.09.2021.
//

import Foundation
import SwiftUI


extension SpacesView {
    var spacesList: some View {
        VStack{                        
            ForEach(spaceStore.spacesOrdered, id: \.id) { space in
                VStack{
                    NavigationLink(
                        destination: SpaceView(spaceId: space.id)) {
                        Spacer().frame(width: 1, height: 12, alignment: .center)
                        SpaceItemView(spaceId: space.id)
                    }                 
//                    .onDrag {
//                        let item = NSItemProvider(object: NSString(string: space.id))
//                        item.suggestedName = space.id
//                        return item
//                    }
//                    .onDrop(of: ["public.utf8-plain-text"], isTargeted: $model.isTarget,
//                            perform: { (provider) -> Bool in
//                                guard let nsProvider = provider.first, let spaceIdSuggest = nsProvider.suggestedName
//                                else { return false}
//                                return spaceStore.reorderSpaces(draggetSpaceId: spaceIdSuggest, dropOnSpaceId: space.id)
//                            })
                }
            }
            Rectangle()
                .foregroundColor(SolColor.colors().screen.background)
                .frame(height: 50, alignment: .center)
                .onDrop(of: ["public.utf8-plain-text"], isTargeted: $model.isTarget,
                        perform: { (provider) -> Bool in
                            guard let nsProvider = provider.first, let spaceIdSuggest = nsProvider.suggestedName
                            else { return false}
                            return spaceStore.moveSpaceToEnd(draggetSpaceId: spaceIdSuggest)
                        })
        }
    }
    
}

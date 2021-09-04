//
//  SpacesViewList.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.09.2021.
//

import Foundation
import SwiftUI
import NavigationStack

extension SpacesView {
    var spacesList: some View {
        VStack{
            
        
        ForEach(model.spaces, id: \.id) { space in
            VStack{
                PushView(destination:  SpaceView(model: SpaceViewModel(space.id))) {
                    Spacer().frame(width: 1, height: 12, alignment: .center)
                    SpaceItemView(icon: space.icon.data, title: space.title)
                }.onDrag {
                    let item = NSItemProvider(object: NSString(string: space.id))
                    item.suggestedName = space.id
                    return item
                }
                .onDrop(of: ["public.utf8-plain-text"], isTargeted: $isTarget,
                        perform: { (provider) -> Bool in
                            guard let nsProvider = provider.first, let spaceIdSuggest = nsProvider.suggestedName
                                else { return false}
                            return model.reorderSpaces(draggetSpaceId: spaceIdSuggest, dropOnSpaceId: space.id)
                })
            }
        }
        Rectangle()
            .foregroundColor(SolColor.colors().screen.background)
            .frame(width: .infinity, height: 50, alignment: .center)
            .onDrop(of: ["public.utf8-plain-text"], isTargeted: $isTarget,
                    perform: { (provider) -> Bool in
                        guard let nsProvider = provider.first, let spaceIdSuggest = nsProvider.suggestedName
                            else { return false}
                        return model.moveSpaceToEnd(draggetSpaceId: spaceIdSuggest)
            })
        }
    }
    
}

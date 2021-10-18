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
        //        ScrollView(.vertical, showsIndicators: false) {
        Group{
            List{
                Spacer()
                    .listRowBackground(SolColor.colors().screen.background)
                    .frame(width: 1, height: 16, alignment: .center)
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                mainInfo
                    
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                
                ForEach(spaceStore.spacesOrdered, id: \.id) { space in
                    VStack {
                        SpaceItemView(spaceId: space.id)
                        NavigationLink(
                            destination: SpaceView(spaceId: space.id)) {
                                EmptyView()
                            }
                            .opacity(0)
                            .frame(width: 0, height: 0)                                                
                    }
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                    .onDrag {
                        let item = NSItemProvider(object: NSString(string: space.id))
                        item.suggestedName = space.id
                        return item
                    }
                }
                .onInsert(of: ["public.utf8-plain-text"], perform: { (var1:Int, var2:[NSItemProvider]) in
                    if var2.count == 0 {
                        return
                    }
                    let spaceId = var2[0].suggestedName
                    print("move \(spaceId) to \(var1) position")
                    
                })
                .moveDisabled(false)
                
                Rectangle()
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                    .foregroundColor(SolColor.colors().screen.background)
                    .frame(height: 50, alignment: .center)
                    .onDrop(of: ["public.utf8-plain-text"], isTargeted: $model.isTarget,
                            perform: { (provider) -> Bool in
                        guard let nsProvider = provider.first, let spaceIdSuggest = nsProvider.suggestedName
                        else { return false}
                        return spaceStore.moveSpaceToEnd(draggetSpaceId: spaceIdSuggest)
                    })
                
                Spacer()
                    .listRowBackground(SolColor.colors().screen.background)
                    .frame(width: 1, height: 142, alignment: .center)
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                
            }
            
            .listStyle(PlainListStyle())
            .background(SolColor.colors().screen.background)
            .ignoresSafeArea(.all)
            .refreshable {
                spaceStore.sync()
            }
        }
    }
}

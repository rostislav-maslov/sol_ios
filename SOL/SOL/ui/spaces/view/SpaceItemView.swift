//
//  SpaceItemComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

struct SpaceItemView: View {
    var spaceId: String
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var taskStore: TaskStore
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(SolColor.colors().screen.background)
                .frame(width: .infinity, height: 50, alignment: .center)
            VStack{
                Spacer()
                    .frame(width: 1, height: 12, alignment: .center)
                HStack{
                    Spacer()
                        .frame(width: 19, height: 1, alignment: .center)
                    Text(self.spaceStore.spaces[spaceId]!.icon.data)
                        .font(SolFonts
                                .font(
                                    size: 20,
                                    weight: Font.Weight.medium,
                                    color: Color.black))
                    Spacer()
                        .frame(width: 6, height: 1, alignment: .center)
                    Text(self.spaceStore.spaces[spaceId]!.title)
                        .font(
                            SolFonts
                                .font(
                                    size: 16,
                                    weight: Font.Weight.medium,
                                    color: SolColor.colors().fontColors.normal)
                        )
                    Spacer()
                }
                Spacer().frame(width: 1, height: 12, alignment: .center)
            }
            
        }.onAppear(perform: {
            for task in spaceStore.spaces[spaceId]!.tasks {
                taskStore.syncTask(taskId: task.id)
            }
        })
    }
}

struct SpaceItemComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpaceItemView(spaceId: "")
            .preferredColorScheme(.light)
    }
}

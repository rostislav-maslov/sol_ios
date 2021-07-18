//
//  SpacesViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import Foundation

public class SpacesViewModel: ObservableObject {
    @Published var goToLogout: Bool = false
    @Published var showAddSpaceSheet: Bool = false
    @Published var spaces: [SpaceEntity] = []
}

extension SpacesViewModel{
    public func onAddSpacesTouch () -> Void {
        showAddSpaceSheet = true
    }
    
    public func onDissmisAddSpace () -> Void {
        showAddSpaceSheet = false
    }
}

extension SpacesViewModel{
    public func load(){
        var space1:SpaceEntity = SpaceEntity()
        space1.id = "1"
        space1.title = "Работа1"
        space1.icon.data = "👩‍🔧"
        
        var space2:SpaceEntity = SpaceEntity()
        space2.id = "2"
        space2.title = "Жизнь"
        space2.icon.data = "🧟"
        
        var space3:SpaceEntity = SpaceEntity()
        space3.id = "3"
        space3.title = "Лайфстайл"
        space3.icon.data = "🏬"
        
        spaces.append(space1)
        spaces.append(space2)
        spaces.append(space3)
    }
}

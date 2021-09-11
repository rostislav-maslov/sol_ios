//
//  SpaceTitleViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.09.2021.
//

import Foundation

public class SpaceTitleModel: ObservableObject, MultilineTextFieldProtocol{
    var spaceStore: SpaceStore?
    var spaceId: String
    
    init(spaceId: String){
        self.spaceId = spaceId
    }
    
    public func textDidChange(text: String){
        spaceStore?.spaces[spaceId]?.title = text
    }
    public func textEditFinish(text: String){
        spaceStore?.saveTitleIcon(spaceId: spaceId, title: text, data: spaceStore!.spaces[spaceId]!.icon.data)
    }
    
}

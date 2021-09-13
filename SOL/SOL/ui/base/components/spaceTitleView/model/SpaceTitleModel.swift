//
//  SpaceTitleViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.09.2021.
//

import Foundation
import Combine

public class SpaceTitleModel: ObservableObject, MultilineTextFieldProtocol{
    var spaceStore: SpaceStore?
    var spaceId: String
    //@Published var title:String = ""
    
    init(spaceId: String){
        self.spaceId = spaceId
    }
    
    public func textDidChange(text: String){
        spaceStore?.spaces[spaceId]?.title = text
        spaceStore?.spaceListLastUpdateUUID = UUID()

    }
    public func textEditFinish(text: String){
        spaceStore?.saveTitleIcon(spaceId: spaceId, title: text, data: spaceStore!.spaces[spaceId]!.icon.data)
    }
    
}

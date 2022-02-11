//
//  EditViewPageMainParams.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.02.2022.
//

import Foundation
import SwiftUI

extension EditViewPage{
    
    var mainParamsContent: some View {
        VStack{
            EditViewChooseLineItem(title: "View type", value: (model.viewUserEntity.view?.viewType ?? ViewType.CUSTOM).description) {
                if model.viewUserEntity.canEdit == true {
                    viewUserStore.viewTypeChooseValue = model.viewUserEntity.view?.viewType ?? ViewType.CUSTOM
                    viewUserStore.viewTypeChooseSheet = true
                }else {
                    viewUserStore.sorrySheet = true
                }
                
            }
            
            Spacer().frame(height: 16)
            
            EditViewChooseLineItem(title: "Added type", value: (model.viewUserEntity.view?.addedType ?? AddedType.MANUALLY).description) {
                if model.viewUserEntity.canEdit == true {
                    viewUserStore.addedTypeChooseValue = model.viewUserEntity.view?.addedType ?? AddedType.MANUALLY
                    viewUserStore.addedTypeChooseSheet = true
                }else {
                    viewUserStore.sorrySheet = true
                }
            }
            
            Spacer().frame(height: 16)
            
            EditViewChooseLineItem(title: "Display mode", value: (model.viewUserEntity.view?.displayMode ?? DisplayMode.LIST).description) {
                if model.viewUserEntity.canEdit == true {
                    viewUserStore.displayModeChooseValue = model.viewUserEntity.view?.displayMode ?? DisplayMode.LIST
                    viewUserStore.displayModeChooseSheet = true
                }else {
                    viewUserStore.sorrySheet = true
                }
            }
            
            Spacer().frame(height: 16)
            
            EditViewChooseLineItem(title: "Sort", value: (model.viewUserEntity.view?.sortType ?? SortType.CUSTOM).description) {
                if model.viewUserEntity.canEdit == true {
                    viewUserStore.sortChooseValue = model.viewUserEntity.view?.sortType ?? SortType.CUSTOM
                    viewUserStore.sortChooseSheet = true
                }else {
                    viewUserStore.sorrySheet = true
                }
            }
            
        }
        .listRowSeparator(Visibility.hidden)
        .listRowBackground(SolColor.colors().screen.background)
    }
}

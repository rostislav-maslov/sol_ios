//
//  NotificationChooseSheet.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import SwiftUI
import BottomSheet

public struct NotificationChooseSheet: View {
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    init(){
        
    }
    
    public var body: some View {
        ZStack {
            
        }.bottomSheet(isPresented: $viewUserStore.notificationChooseSheet, height: 300.0) {
            VStack(alignment: HorizontalAlignment.leading){
                HStack{
                    Text("Has notification")
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                    Spacer()
                }
                
                Spacer().frame( height: 16)
                
                VStack{
                    HStack{
                        Toggle("Task has notification", isOn: $viewUserStore.notificationChooseValue)
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            viewUserStore.notificationChooseDelete!(viewUserStore.notificationChooseId)
                        } label: {
                            Text("Delete")
                                .foregroundColor(SolColor.colors().fontColors.normal)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                        Button {
                            viewUserStore.notificationChooseDidChange!(viewUserStore.notificationChooseId,   viewUserStore.notificationChooseValue)
                        } label: {
                            Text("Save")
                                .foregroundColor(SolColor.colors().fontColors.normal)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                    }
                    Spacer().frame(height: 8.0)
                   
                }
                
                Spacer()
            }.padding(8.0)
            
        }
    }
}

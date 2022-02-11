//
//  DeadlineRelativeChooseSheet.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import SwiftUI
import BottomSheet

public struct RelativePicker{
    var key: Int
    var value: String
}

public struct DeadlineRelativeChooseSheet: View {
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    init(){
        
    }
    
    public var body: some View {
        ZStack {
            
        }.bottomSheet(isPresented: $viewUserStore.deadlineRelativeChooseSheet, height: 400.0) {
            VStack(alignment: HorizontalAlignment.leading){
                HStack{
                    Text("Deadline Relative")
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                    Spacer()
                }
                
                Spacer().frame( height: 16)
                
                VStack{
                    HStack{
                        Picker("Choose value", selection: $viewUserStore.deadlineRelativeChooseValue) {
                            Text("Просрочено").tag(-1)
                            Text("Сегодня").tag(0)
                            Text("Завтра").tag(1)
                            Text("В течении недели").tag(2)
                            Text("В течении двух недель").tag(3)
                            Text("В течении текущего месяца").tag(4)
                        }.pickerStyle(.wheel)
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            viewUserStore.deadlineRelativeDelete!(viewUserStore.deadlineRelativeChooseId)
                        } label: {
                            Text("Delete")
                                .foregroundColor(SolColor.colors().fontColors.normal)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                        Button {
                            viewUserStore.deadlineRelativeDidChange!(viewUserStore.deadlineRelativeChooseId, viewUserStore.deadlineRelativeChooseValue)
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

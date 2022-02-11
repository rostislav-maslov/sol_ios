//
//  DisplayModeChooseSheet.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import SwiftUI
import BottomSheet

public struct DisplayModeChooseSheet: View {
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    init(){
        
    }
    
    public var body: some View {
        ZStack {
            
        }.bottomSheet(isPresented: $viewUserStore.displayModeChooseSheet, height: 300.0) {
            VStack(alignment: HorizontalAlignment.leading){
                HStack{
                    Text("DisplayModeChooseSheet")
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                    Spacer()
                }
                
                Spacer().frame( height: 16)
                
                VStack{
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.displayModeChooseSheet?(DisplayMode.LIST)
                            viewUserStore.displayModeChooseSheet = false                            
                        } label: {
                            Text("List")
                                .foregroundColor(
                                    viewUserStore.displayModeChooseValue == DisplayMode.LIST ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.displayModeChooseSheet?(DisplayMode.CONCENTRATE)
                            viewUserStore.displayModeChooseSheet = false
                        } label: {
                            Text("Concentrate")
                                .foregroundColor(
                                    viewUserStore.displayModeChooseValue == DisplayMode.CONCENTRATE ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second
                                )
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.displayModeChooseSheet?(DisplayMode.TIMELINE)
                            viewUserStore.displayModeChooseSheet = false
                        } label: {
                            Text("Timeline")
                                .foregroundColor(
                                    viewUserStore.displayModeChooseValue == DisplayMode.TIMELINE ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second
                                )
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }                    
                }
                
                Spacer()
            }.padding(8.0)
            
        }
    }
}

//
//  SortChooseSheet.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import SwiftUI
import BottomSheet

public struct SortChooseSheet: View {
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    init(){
        
    }
    
    public var body: some View {
        ZStack {
            
        }.bottomSheet(isPresented: $viewUserStore.sortChooseSheet, height: 300.0) {
            VStack(alignment: HorizontalAlignment.leading){
                HStack{
                    Text("SortChooseSheet")
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                    Spacer()
                }
                
                Spacer().frame( height: 16)
                
                VStack{
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.sortChooseSheet?(SortType.CUSTOM)
                            viewUserStore.sortChooseSheet = false
                        } label: {
                            Text("Custom")
                                .foregroundColor(
                                    viewUserStore.sortChooseValue == SortType.CUSTOM ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second
                                )
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.sortChooseSheet?(SortType.BY_DEADLINE)
                            viewUserStore.sortChooseSheet = false
                        } label: {
                            Text("By Deadline")
                                .foregroundColor(
                                    viewUserStore.sortChooseValue == SortType.BY_DEADLINE ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second
                                )
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.sortChooseSheet?(SortType.BY_CREATE)
                            viewUserStore.sortChooseSheet = false
                        } label: {
                            Text("By Create")
                                .foregroundColor(
                                    viewUserStore.sortChooseValue == SortType.BY_CREATE ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second
                                )
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.sortChooseSheet?(SortType.BY_TITLE)
                            viewUserStore.sortChooseSheet = false
                        } label: {
                            Text("By Title")
                                .foregroundColor(
                                    viewUserStore.sortChooseValue == SortType.BY_TITLE ?
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

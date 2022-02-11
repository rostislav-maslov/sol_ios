//
//  ViewFiltersView.swift
//  SOL
//
//  Created by Rostislav Maslov on 31.01.2022.
//

import Foundation
import SwiftUI
import BottomSheet

public struct ViewFiltersModal: View {
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    init(){
        
    }
    
    public var body: some View {
        ZStack {
                
        }.bottomSheet(isPresented: $viewUserStore.showFilterSheet, height: 350.0) {
            VStack(alignment: HorizontalAlignment.leading){
                HStack{
                    Text("Filter")
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                    Spacer()
                }
                
                Spacer().frame( height: 16)
                
                VStack{
                    HStack{
                        Button {
                            
                        } label: {
                            Text("All")
                                .foregroundColor(SolColor.colors().fontColors.normal)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            
                        } label: {
                            Text("Overdue")
                                .foregroundColor(SolColor.colors().fontColors.second)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            
                        } label: {
                            Text("Today")
                                .foregroundColor(SolColor.colors().fontColors.second)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                }
                VStack{
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            
                        } label: {
                            Text("Tomorrow")
                                .foregroundColor(SolColor.colors().fontColors.second)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            
                        } label: {
                            Text("This week")
                                .foregroundColor(SolColor.colors().fontColors.second)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            
                        } label: {
                            Text("Later")
                                .foregroundColor(SolColor.colors().fontColors.second)
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





//
//  ViewTypeChooseSheet.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import SwiftUI
import BottomSheet

public struct ViewTypeChooseSheet: View {
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    init(){
        
    }
    
    public var body: some View {
        ZStack {
            
        }.bottomSheet(isPresented: $viewUserStore.viewTypeChooseSheet, height: 300.0) {
            VStack(alignment: HorizontalAlignment.leading){
                HStack{
                    Text("ViewTypeChooseSheet")
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                    Spacer()
                }
                
                Spacer().frame( height: 16)
                
                VStack{
                    HStack{
                        Button {
                            self.viewUserStore.viewUserConf.viewTypeChooseSheet?(ViewType.CUSTOM)
                            self.viewUserStore.viewTypeChooseSheet = false
                        } label: {
                            Text("Custom")
                                .foregroundColor(
                                    self.viewUserStore.viewTypeChooseValue == .CUSTOM ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second)
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            self.viewUserStore.viewUserConf.viewTypeChooseSheet?(ViewType.PARAMS)
                            self.viewUserStore.viewTypeChooseSheet = false
                        } label: {
                            Text("Params")
                                .foregroundColor(
                                    self.viewUserStore.viewTypeChooseValue == .PARAMS ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second)
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

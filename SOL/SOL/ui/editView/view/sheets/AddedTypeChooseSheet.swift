//
//  AddedTypeChooseSheet.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import SwiftUI
import BottomSheet

public struct AddedTypeChooseSheet: View {
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    init(){
        
    }
    
    public var body: some View {
        ZStack {
            
        }.bottomSheet(isPresented: $viewUserStore.addedTypeChooseSheet, height: 300.0) {
            VStack(alignment: HorizontalAlignment.leading){
                HStack{
                    Text("AddedTypeChooseSheet")
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                    Spacer()
                }
                
                Spacer().frame( height: 16)
                
                VStack{
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.addedTypeChooseSheet?(AddedType.AUTO)
                            viewUserStore.addedTypeChooseSheet = false
                        } label: {
                            Text("Auto")
                                .foregroundColor(
                                    viewUserStore.addedTypeChooseValue == AddedType.AUTO ?
                                    SolColor.colors().fontColors.normal : SolColor.colors().fontColors.second
                                )
                                .font(SolFonts.font(size: 24, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    Spacer().frame(height: 8.0)
                    HStack{
                        Button {
                            viewUserStore.viewUserConf.addedTypeChooseSheet?(AddedType.MANUALLY)
                            viewUserStore.addedTypeChooseSheet = false
                        } label: {
                            Text("Manually")
                                .foregroundColor(
                                    viewUserStore.addedTypeChooseValue == AddedType.MANUALLY ?
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

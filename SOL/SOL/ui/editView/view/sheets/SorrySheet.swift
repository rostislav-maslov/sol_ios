//
//  SorrySheet.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.02.2022.
//

import Foundation
import SwiftUI
import BottomSheet

public struct SorrySheet: View {
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    init(){
        
    }
    
    public var body: some View {
        ZStack {
            
        }.bottomSheet(isPresented: $viewUserStore.sorrySheet, height: 400.0) {
            VStack(alignment: HorizontalAlignment.leading){
                HStack{
                    Text("Sorry but")
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                   
                    Spacer()
                }
                
                Text("you cannt edit this view because its not available to edit. ")
                    .foregroundColor(SolColor.colors().fontColors.normal)
                    .font(SolFonts.font(size: 16, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                
                Spacer()
            }.padding(8.0)
            
        }
    }
}

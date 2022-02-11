//
//  ViewWithTasksFilters.swift
//  SOL
//
//  Created by Rostislav Maslov on 31.01.2022.
//

import Foundation
import SwiftUI
import BottomSheet


extension ViewWithTasksView {
    var filters: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .top, spacing: 0, content: {
                Spacer().frame(width: 16, height: 11, alignment: .center)
                
                Button {
                    viewUserStore.showSortSheet = true
                } label: {
                    HStack{
                        Text("Sort by deadline")
                            .font(SolFonts.font(size: 15.0, weight: Font.Weight.regular, color: Color.white))
                            .foregroundColor(SolColor.colors().filterButton.font)
                        Image("ic_task_item_expand")
                    }.padding(EdgeInsets(top: 4.0, leading: 8.0, bottom: 4.0, trailing: 8.0))
                }
                .buttonStyle(DefaultButtonStyle())
                .foregroundColor(SolColor.colors().filterButton.background)
                .background(SolColor.colors().filterButton.background)
                .cornerRadius(8.0)
                
                Spacer().frame(width: 8, height: 11, alignment: .center)
                            
                Button {
                    viewUserStore.showDisplayModeSheet = true
                } label: {
                    HStack{
                        Text("Show as list")
                            .font(SolFonts.font(size: 15.0, weight: Font.Weight.regular, color: Color.white))
                            .foregroundColor(SolColor.colors().filterButton.font)
                        Image("ic_task_item_expand")
                    }.padding(EdgeInsets(top: 4.0, leading: 8.0, bottom: 4.0, trailing: 8.0))
                }
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(SolColor.colors().filterButton.background)
                .background(SolColor.colors().filterButton.background)
                .cornerRadius(8.0)
                            
                Spacer().frame(width: 8, height: 11, alignment: .center)
                            
                Button {
                    viewUserStore.showFilterSheet = true
                } label: {
                    HStack{
                        Text("filter")
                            .font(SolFonts.font(size: 15.0, weight: Font.Weight.regular, color: Color.white))
                            .foregroundColor(SolColor.colors().filterButton.font)
                        Image("ic_task_item_expand")
                    }.padding(EdgeInsets(top: 4.0, leading: 8.0, bottom: 4.0, trailing: 8.0))
                }
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(SolColor.colors().filterButton.background)
                .background(SolColor.colors().filterButton.background)
                .cornerRadius(8.0)
                
                Spacer()
                Spacer().frame(width: 16, height: 1, alignment: .center)
            })
        }
    }
}


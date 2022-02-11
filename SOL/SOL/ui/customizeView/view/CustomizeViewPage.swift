//
//  CustomizeViewPage.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import SwiftUI

public struct CustomizeViewPage: View {
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    
    @State var isTarget = false
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    public var body: some View {
        ZStack {
            List{
                VStack{
                    HeaderComponent(value: "Customize View"){}
                    Spacer()
                        .frame(width: 0.0, height: 24.0, alignment: Alignment.center)
                }
                .listRowSeparator(Visibility.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(SolColor.colors().screen.background)
                
                ForEach(viewUserStore.root, id: \.id)  { viewUser in
                    NavigationLink(destination: EditViewPage(viewId: viewUser.id)) {
                        VStack{
                            HStack{
                                Spacer().frame(width: 16.0, height: 0.0, alignment: Alignment.center)
                                Text(viewUser.view!.title ?? "")
                                    .foregroundColor(SolColor.colors().fontColors.normal)
                                    .font(SolFonts.font(size: 20.0, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                                Spacer()
                                Button("Hide") {
                                    viewUserStore.hide(viewId: viewUser.id)
                                }.buttonStyle(PlainButtonStyle())
                                
                                Spacer().frame(width: 10.0, height: 8.0, alignment: Alignment.center)
                            }
                        }
                    }
                    .moveDisabled(false)
                    .buttonStyle(.plain)
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                    .onDrag {
                        let item = NSItemProvider(object: NSString(string: viewUser.id))
                        item.suggestedName = viewUser.id
                        return item
                    }
                }                
                .onInsert(of: ["public.utf8-plain-text"], perform: { (index:Int, provider:[NSItemProvider]) in
                    guard let nsProvider = provider.first, let viewId = nsProvider.suggestedName
                                            else { return }
                    self.viewUserStore.reorder(viewId, index)
                })
                .listRowSeparator(Visibility.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(SolColor.colors().screen.background)
                .moveDisabled(false)
                
                
                if viewUserStore.hides.count > 0 {
                    VStack{
                        Spacer()
                            .frame(width: 0.0, height: 64.0, alignment: Alignment.center)
                        HeaderComponent(value: "Hides"){}
                        Spacer()
                            .frame(width: 0.0, height: 24.0, alignment: Alignment.center)
                    }
                    .moveDisabled(true)
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                }                                
                
                ForEach(viewUserStore.hides, id: \.id)  { viewUser in
                    NavigationLink(destination: EditViewPage(viewId: viewUser.id)) {
                        VStack{
                            HStack{
                                Spacer().frame(width: 16.0, height: 0.0, alignment: Alignment.center)
                                Text(viewUser.view!.title ?? "")
                                    .foregroundColor(SolColor.colors().fontColors.normal)
                                    .font(SolFonts.font(size: 20.0, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                                
                                Spacer()
                                Button("Show") {
                                    viewUserStore.show(viewId: viewUser.id)
                                }.buttonStyle(PlainButtonStyle())
                                
                                Spacer().frame(width: 10.0, height: 8.0, alignment: Alignment.center)
                            }
                        }
                    }
                    .moveDisabled(true)
                    .buttonStyle(.plain)
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                    
                }
                .moveDisabled(true)
                .listRowSeparator(Visibility.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(SolColor.colors().screen.background)
                
            }
            
            .listStyle(PlainListStyle())
            .background(SolColor.colors().screen.background)
            .ignoresSafeArea(.all)
        }
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .preferredColorScheme(.light)
        .navigationTitle("Customize View")
        .navigationBarHidden(false)
        
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(
                    destination: EditViewPage()) {
                        Text("Create")
                    }.buttonStyle(.plain)
            }
        }
        .onAppear(perform: {
            addTaskModel.state = .HIDDEN
        })
        .onDisappear {
            //addTaskModel.state = .PLACEHOLDER
        }
    }
}




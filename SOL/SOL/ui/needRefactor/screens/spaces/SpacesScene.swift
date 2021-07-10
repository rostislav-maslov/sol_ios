//
//  ZContainer.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.05.2021.
//

import SwiftUI

class ZContainerViewModel: ObservableObject {
    @Published var goToLogout: Bool = false
    @Published var showAddSpaceSheet: Bool = false
    @Published var spaces: [SpaceResponse] = []
}

struct SpacesScene: View {
    @ObservedObject var viewModel = ZContainerViewModel()
    
    
    func onAddSpacesTouch () -> Void {
        self.viewModel.showAddSpaceSheet = true
    }
    
    func onDissmisAddSpace () -> Void {
        self.viewModel.showAddSpaceSheet = false
    }
    
    func updateSpaces() -> Void {
    
    }
    
    func dataUpdated() {
        DispatchQueue.main.async {
            self.viewModel.spaces = []
    //        self.viewModel.spaces = solData.space!.spaces
        }        
    }
    
    func observableKey() -> String {
        return "SpacesScene"
    }
    
    var body: some View {
        ZStack {
            
            NavigationLink(destination: LoginUIView(), isActive: $viewModel.goToLogout) {EmptyView()}
            
            
            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                    .frame(width: 1, height: 41+16, alignment: .center)
                VStack{
                    HeaderComponent(value: "username") {
//                        SolDataProvider.shared().user?.logout {
//                            self.viewModel.goToLogout = true
//                        }
                    }
                    StoriesComponent()
                    Spacer()
                        .frame(width: 1, height: 16, alignment: .center)
                    TaskTitleComponent(icon: "🤘", title: "Your SOL", showAddButton: false, addButtonDidTouch: nil)
                    Spacer()
                        .frame(width: 1, height: 16, alignment: .center)
                    CommandMenuComponent()
                    Spacer()
                        .frame(width: 1, height: 16, alignment: .center)
                    TaskTitleComponent(icon: "🧑‍🚀", title: "Spaces", showAddButton: true) {
                        self.onAddSpacesTouch()
                    }
                    Spacer().frame(width: 1, height: 16, alignment: .center)
                    
                }
                
                ForEach(viewModel.spaces, id: \.id) { space in
                    VStack{
                        Spacer().frame(width: 1, height: 12, alignment: .center)
                        SpaceItemComponent(icon: space.icon.data, title: space.title)}
                }
                
                Spacer()
                    .frame(width: 1, height: 142, alignment: .center)
                
                
                EmptyView()
                    .sheet(isPresented: $viewModel.showAddSpaceSheet, onDismiss:{
                        self.onDissmisAddSpace()
                    }) {
                        AddSpaceScreen {
                            viewModel.showAddSpaceSheet = false
                    //        solData.space?.updateSpaces()
                        }
                        
                    }
                    .background(SolColor.colors().screen.background)
                    .preferredColorScheme(.light)
            }
            .background(SolColor.colors().screen.background)
            .ignoresSafeArea(.all)
            AddTaskComponent()
        }
        .preferredColorScheme(.light)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
        .onAppear(perform: {
           // solData.listen(self)
          //  solData.space?.updateSpaces()
        })
        .onDisappear(perform: {
            //solData.stopListen(self)
        })
    }
}

struct SpacesScene_Previews: PreviewProvider {
    static var previews: some View {
        SpacesScene()
        
    }
}



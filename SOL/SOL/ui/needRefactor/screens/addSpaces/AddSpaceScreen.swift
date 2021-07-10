//
//  AddSpaceScreen.swift
//  SOL
//
//  Created by Rostislav Maslov on 30.05.2021.
//

import SwiftUI

class AddSpaceViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var state: ViewState = ViewState.NORMAL
    @Published var emoji: String = "🪐"
}

struct AddSpaceScreen: View {
    @ObservedObject var viewModel = AddSpaceViewModel()
    @State var createSpace: ViewState = ViewState.NORMAL
    let spaceAdded: () -> Void
    
    
    var body: some View {
        ZStack {
            SolColor.colors().screen.background.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Create Space")
                        .font(SolFonts.font(size: 32, weight: Font.Weight.black, color: SolColor.colors().fontColors.normal))
                    Spacer()
                }
                Spacer().frame(width: 0, height: 16, alignment: .center)
                HStack {
                    IconFieldComponent(placeholder: "🪐", value: $viewModel.emoji, state: $viewModel.state)
                    Spacer().frame(width: 8, height: 0, alignment: .center)
                    TextFieldLoginComponent(placeholder: "Title", value: $viewModel.title, secured: false, keyboardType: .default, state: $viewModel.state, autocapitalization: UITextAutocapitalizationType.sentences)
                }
                Spacer().frame(width: 0, height: 16, alignment: .center)
                ButtonComponent(title: "Create", state: $createSpace) {
//                    solData.space?.create(title: self.viewModel.title, icon: self.viewModel.emoji, callback: {
//                        self.spaceAdded()
//                    })
                }
            }.padding()
        }
        .preferredColorScheme(.light)
        .onAppear(perform: {
            
        })
    }
}

struct AddSpaceScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddSpaceScreen {
            
        }
    }
}

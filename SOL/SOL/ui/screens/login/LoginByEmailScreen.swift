//
//  LoginByEmail.swift
//  SOL
//
//  Created by Rostislav Maslov on 27.04.2021.
//

import SwiftUI
import Combine
import ToastUI


class LogByEmailViewModel: ObservableObject {
    @Published var state: ViewState = .NORMAL
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var navigateToController: Bool = false
}

struct LoginByEmailScreen: View, SolDataObservable {
    @ObservedObject var viewModel = LogByEmailViewModel()
    
    let data: SolDataProvider = SolDataProvider.shared()
    
    init() {
        UINavigationBar.appearance().tintColor = .black
        self.data.listen(self)
    }
    
    func dataUpdated() {
        DispatchQueue.main.async {
            if self.data.user?.state == .LOGGED {                
                self.viewModel.state = .NORMAL
                self.viewModel.navigateToController = true
            } else {
                self.viewModel.state = .ERROR
            }
        }
    }
    
    func observableKey() -> String {
        return "LoginByEmailScreen"
    }
    
    func onSubmitTouch() -> Void {
        if self.viewModel.state != .LOADING {
            self.viewModel.state = .LOADING
            self.data.user?.signUp(
                email: self.viewModel.email,
                password: self.viewModel.password,
                error: {
                })
        }
    }
    
    var body: some View {

            ZStack {
                NavigationLink(destination: SpacesScene(), isActive: $viewModel.navigateToController) {EmptyView()}
                
                SolColor.colors().screen.background.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    // basic usage
                    TitleLoginByEmailComponent()
                    Spacer().frame(width: 1, height: 32, alignment: .center)
                    TextFieldLoginComponent(placeholder: "Email", value: $viewModel.email, secured: false, keyboardType: .emailAddress, state: $viewModel.state)
                    Spacer().frame(width: 0, height: 16, alignment: .center)
                    TextFieldLoginComponent(placeholder: "Password", value: $viewModel.password, secured: true, state: $viewModel.state)
                    Spacer().frame(height: 32.0)
                    ButtonComponent(title: "Submit", state: $viewModel.state,  action: self.onSubmitTouch)
                    Spacer().frame(width: 1, height: 100, alignment: .center)
//                    Spacer().frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: 64, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
                }.padding()
            }

        .onAppear(perform: {
            print("dd")
        })
        .onDisappear(perform: {
            self.data.stopListen(self)
        })
    }
}

struct LoginByEmail_Previews: PreviewProvider {
    static var previews: some View {
        LoginByEmailScreen()
            .preferredColorScheme(.light)
    }
}

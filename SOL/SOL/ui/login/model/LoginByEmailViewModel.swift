//
//  LoginByEmailViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.07.2021.
//

import Foundation
import Combine

class LoginByEmailViewModel: ObservableObject {
    @Published var state: ViewState = .NORMAL
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var navigateToController: Bool = false
    let data: SolDataProvider = SolDataProvider.shared()
    
    func dataUpdated() {
        DispatchQueue.main.async {
            if self.data.user?.state == .LOGGED {
                self.state = .NORMAL
                self.navigateToController = true
            } else {
                self.state = .ERROR
            }
        }
    }
    
    func observableKey() -> String {
        return "LoginByEmailScreen"
    }
    
    func onSubmitTouch() -> Void {
        if self.state != .LOADING {
            self.state = .LOADING
            self.data.user?.signUp(
                email: self.email,
                password: self.password,
                error: {
                })
        }
    }
    
}

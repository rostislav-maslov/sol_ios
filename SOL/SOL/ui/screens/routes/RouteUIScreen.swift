//
//  RouteUIView.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.04.2021.
//

import SwiftUI

struct RouteUIScreen: View {
    @State var goToLogin = false
    @State var goToSpaces = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: LoginUIView(), isActive: $goToLogin) {}
                NavigationLink(destination: SpacesScene(), isActive: $goToSpaces) {}
                ProgressView()
            }.navigationBarHidden(true)
        }.navigationBarHidden(true)
        
        .onAppear(perform: {
            SolDataProvider.shared().user?.warmUp(callback: { (state: AuthState) in
                if state == AuthState.LOGGED {
                    self.goToLogin = false
                    self.goToSpaces = true
                }
                if state == AuthState.UNLOGGED {
                    self.goToLogin = true
                }
            })
        })       
    }
}

struct RouteUIScreen_Previews: PreviewProvider {
    static var previews: some View {
        RouteUIScreen()
            .preferredColorScheme(.light)
    }
}

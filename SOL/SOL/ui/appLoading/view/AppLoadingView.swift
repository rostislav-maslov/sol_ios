//
//  RouteUIView.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.04.2021.
//

import SwiftUI

struct AppLoadingView: View {
    @ObservedObject var viewModel: AppLoadingViewModel = AppLoadingViewModel()
    
    init() {
        NavigationBarHelper.updateHeightDelta()
    }
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(
                    destination: LoginUIView(),
                    isActive: $viewModel.goToLogin) {}
                NavigationLink(
                    destination: SpacesView(),//TestView()
                    isActive: $viewModel.goToSpaces) {}
                ProgressView()
            }.navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .environmentObject(SpaceStore())
        .environmentObject(TaskStore())
        .environmentObject(EnvStore())
        .onAppear(perform: viewModel.refresh)
    }
}

struct RouteUIScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppLoadingView()
            .preferredColorScheme(.light)
    }
}

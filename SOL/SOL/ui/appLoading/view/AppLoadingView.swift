//
//  RouteUIView.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.04.2021.
//

import SwiftUI


struct AppLoadingView: View {
    @ObservedObject var viewModel: AppLoadingViewModel = AppLoadingViewModel()
    @State var goToState:AppLoadingState?
    
    init() {
        NavigationBarHelper.updateHeightDelta()
        goToState = .INIT
    }
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: LoginUIView(), tag: AppLoadingState.LOGIN, selection: $goToState) {
                    
                }
                NavigationLink(destination: SpacesView(), tag: AppLoadingState.SPACES, selection: $goToState) {
                }
                
                ProgressView()
            }
            .id(viewModel.id)
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .accentColor( .black)
        .environmentObject(SpaceStore())
        .environmentObject(TaskStore())
        .environmentObject(EnvStore())
        .onAppear(perform: {
            viewModel.refresh { result in
                self.goToState = result
            }
        })
    }
}

struct RouteUIScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppLoadingView()
            .preferredColorScheme(.light)
    }
}

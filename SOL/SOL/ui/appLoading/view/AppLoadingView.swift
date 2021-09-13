//
//  RouteUIView.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.04.2021.
//

import SwiftUI
import NavigationStack

struct AppLoadingView: View {
    @ObservedObject var viewModel: AppLoadingViewModel = AppLoadingViewModel()
    @State var goToState:AppLoadingState?
    
//    var spaceStore: SpaceStore
//    var taskStore: TaskStore
//    var spaceStore: EnvStore
    
    init() {
        NavigationBarHelper.updateHeightDelta()
        goToState = .INIT
    }
    
    var body: some View {
//        NavigationView{
        NavigationStackView{
            VStack{
                PushView(destination: LoginUIView(), tag: AppLoadingState.LOGIN, selection: $goToState) {
                    
                }
                PushView(destination: SpacesView(), tag: AppLoadingState.SPACES, selection: $goToState) {
                    
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

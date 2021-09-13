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
    @State var goToSpace = false
    
//    var spaceStore: SpaceStore
//    var taskStore: TaskStore
//    var spaceStore: EnvStore
    
    init() {
        NavigationBarHelper.updateHeightDelta()
    }
    
    var body: some View {
//        NavigationView{
        NavigationStackView{
            VStack{
                PushView(
                    destination: LoginUIView(),
                    isActive: $viewModel.goToLogin) {}
                PushView(
                    destination: SpacesView(),//TestView()
                    isActive: $goToSpace) {}
                
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
                self.goToSpace = result
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

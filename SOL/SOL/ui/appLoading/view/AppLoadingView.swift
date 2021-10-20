//
//  RouteUIView.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.04.2021.
//

import SwiftUI


struct AppLoadingView: View {
    @StateObject var viewModel: AppLoadingViewModel = AppLoadingViewModel()
    @State var goToState:AppLoadingState?
    
    init() {
        NavigationBarHelper.updateHeightDelta()
        goToState = .INIT
    }
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    NavigationLink(
                        destination: LoginUIView(),
                        tag: AppLoadingState.LOGIN,
                        selection: $goToState) {
                        }
                    NavigationLink(
                        destination: SpacesView(),
                        tag: AppLoadingState.SPACES,
                        selection: $goToState) {
                        }
                    
                    ProgressView()
                }
                .navigationBarHidden(true)
            }
            .navigationBarHidden(true)
            .accentColor( .black)
            
            AppModalViews(goToState: $goToState)
        }
        .environmentObject(SpaceStore())
        .environmentObject(TaskStore())
        .environmentObject(EnvStore())
        .environmentObject(AddTaskViewModel())
        .environmentObject(SlotStore())
        .environmentObject(PlanningSlotsModel())
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

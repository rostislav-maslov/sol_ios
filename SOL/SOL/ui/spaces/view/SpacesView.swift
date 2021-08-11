//
//  ZContainer.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.05.2021.
//

import SwiftUI
import NavigationStack

struct SpacesView: View {
    @ObservedObject var model = SpacesViewModel()
    @ObservedObject var addTaskViewModel = AddTaskViewModel(nil, parentTaskId: nil)
    @State var defaultTaskAddTitle = "in Inbox"
    var body: some View {
        NavigationStackView{
            ZStack {
                NavigationLink(destination: LoginUIView(), isActive: $model.goToLogout) {EmptyView()}
                content
                AddTaskRootView(model: addTaskViewModel, parentTitle: $defaultTaskAddTitle)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .preferredColorScheme(.light)
            .onAppear(perform: {
                model.load()
            })
        }
    }
}

extension SpacesView{
    var mainInfo: some View {
        VStack{
            HeaderComponent(value: "username") {                    }
            StoriesComponent()
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            TaskTitleComponent(icon: "🤘", title: "Your SOL", showAddButton: false, addButtonDidTouch: nil)
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            actionButtons
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            TaskTitleComponent(icon: "🧑‍🚀", title: "Spaces", showAddButton: true) {
                model.onAddSpacesTouch()
            }
            Spacer().frame(width: 1, height: 16, alignment: .center)
            
        }
    }
}

extension SpacesView {
    var actionButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                VStack {
                    Spacer()
                        .frame(width: 5, height: 10, alignment: .center)
                }
                VStack {
                    ActionButtonView(
                        title: "Done",
                        titleColor: SolColor.colors().actionButton.taskDone,
                        icon: "ic_check_done",
                        iconColor: SolColor.colors().actionButton.taskDone,
                        iconWidth: 14,
                        iconHeight: 14,
                        iconVerticalSpace: 4,
                        subTitle: "Go back to work"
                    )
                    ActionButtonView(
                        title: "Done",
                        titleColor: SolColor.colors().actionButton.taskDone,
                        icon: "ic_check_done",
                        iconColor: SolColor.colors().actionButton.taskDone,
                        iconWidth: 14,
                        iconHeight: 14,
                        iconVerticalSpace: 4,
                        subTitle: "Go back to work"
                    )
                }                               
                VStack {
                    Spacer()
                        .frame(width: 10, height: 10, alignment: .center)
                }
                
            }
        }
    }
}

extension SpacesView {
    var spacesList: some View {
        ForEach(model.spaces, id: \.id) { space in
            VStack{
                PushView(destination:  SpaceView(model: SpaceViewModel(space.id))) {
                    Spacer().frame(width: 1, height: 12, alignment: .center)
                    SpaceItemView(icon: space.icon.data, title: space.title)
                }                
            }
        }
        
    }
}

extension SpacesView {
    func needCloseSheet(){
        model.onDissmisAddSpace()
        model.load()
    }
    
    var addSpaceSheet: some View {
        EmptyView()
            .sheet(isPresented: $model.showAddSpaceSheet, onDismiss:{
                model.onDissmisAddSpace()
            }) {
                AddSpaceView(viewModel: AddSpaceViewModel(needCloseSheet: self.needCloseSheet))
            }
            .background(SolColor.colors().screen.background)
            .preferredColorScheme(.light)
    }
}

extension SpacesView {
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer()
                .frame(width: 1, height: 41+16, alignment: .center)
            mainInfo
            spacesList
            Spacer()
                .frame(width: 1, height: 142, alignment: .center)
            addSpaceSheet
        }
        .background(SolColor.colors().screen.background)
        .ignoresSafeArea(.all)
    }
}

struct SpacesView_Previews: PreviewProvider {
    static var previews: some View {
        SpacesView()
        
    }
}




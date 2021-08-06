//
//  SpaceView.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation


import SwiftUI
import NavigationStack

struct SpaceView: View {
    @ObservedObject var model: SpaceViewModel
    @EnvironmentObject private var navigationStack: NavigationStack    
    
    init(model: SpaceViewModel){
        self.model = model
    }

    var body: some View {        
        ZStack {
            content
            SolNavigationView()
            AddTaskRootView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
        .onAppear(perform: {
            self.model.load()
        })
    }
}

extension SpaceView {
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            header
            actionsTitle
            actionsButton
            picker
            pickerContainer
            
        }
        .background(SolColor.colors().screen.background)
        .ignoresSafeArea(.all)
        .gesture(
            DragGesture(coordinateSpace: .local)
                .onEnded { value in
                    if value.startLocation.x > .zero && value.startLocation.x < 48{
                        if value.translation.width > .zero
                            && value.translation.height > -30
                            && value.translation.height < 30 {
                            self.navigationStack.pop()
                            print("DragGesture")
                        }
                    }else{
                        if value.translation.width > .zero
                            && value.translation.height > -30
                            && value.translation.height < 30 {
                            if model.activeTab - 1 >= 0 {
                                model.activeTab = model.activeTab - 1
                            }
                            print(model.activeTab)
                            print(value.translation.width)
                        }else{
                            if model.activeTab + 1 <= model.activeTabMax {
                                model.activeTab = model.activeTab + 1
                            }
                            print(model.activeTab)
                            print(value.translation.width)
                        }
                    }
                }
        )
    }
}

extension SpaceView {
    var picker: some View {
        HStack{
            Spacer().frame(width: 12, height: 1, alignment: .center)
            Picker(selection: $model.activeTab, label: Text("")) {
                Text("Tasks").tag(0)
                Text("Details").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer().frame(width: 12, height: 1, alignment: .center)
        }
    }
    
    var pickerContainer: some View {
        VStack{
            if(model.activeTab == 0){
                subtasks
            }
            if(model.activeTab == 1){
                Text("Details")
            }
            Spacer().frame(height: 142)
        }
    }
}

extension SpaceView {
    var header: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            headerSpacer
            taskTitle
            Spacer().frame(width: 1, height: .infinity, alignment: .center)
        })
    }
}

extension SpaceView {
    var actionToggleView: some View {
        VStack{
            if (model.actionToggle == false){
                ActionButtonView(
                    title: "Toggle",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_arrow-tab",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 16,
                    iconHeight: 16,
                    iconVerticalSpace: 4,
                    subTitle: "Show all subtask") {
                    self.model.actionToggle = !self.model.actionToggle
                }
            }else {
                ActionButtonView(
                    title: "Toggle",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_arrow-tab",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Hide all subtask"){
                    self.model.actionToggle = !self.model.actionToggle
                }
            }
        }
    }
    
    var planningActionView: some View {
        VStack{
            if (model.actionPlanning == false){
                ActionButtonView(
                    title: "Planning",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_calendar",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Your plan 4h"){
                    self.model.actionPlanning = !self.model.actionPlanning
                }
                
            }else {
                ActionButtonView(
                    title: "Planning",
                    titleColor: SolColor.colors().checkBox.doneBackground,
                    icon: "ic_calendar",
                    iconColor: SolColor.colors().checkBox.doneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Tap to set time"){
                    self.model.actionPlanning = !self.model.actionPlanning
                }
            }
        }
    }
    
    var actionsButton: some View {
        VStack{
            Spacer().frame(width: 1, height: 16, alignment: .center)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    VStack {
                        Spacer()
                            .frame(width: 5, height: 10, alignment: .center)
                    }
                    VStack {
                        actionToggleView
                    }
                    VStack {
                        planningActionView
                    }
                    
                    VStack {
                        Spacer()
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                }
            }
            Spacer().frame(width: 1, height: 16, alignment: .center)
        }
    }
}

extension SpaceView {
    var taskTitle: some View {
        
        HStack(alignment: .top, spacing: 0, content: {
            Spacer().frame(width: 16, height: 11, alignment: .center)
            Spacer().frame(width: 8, height: 1, alignment: .center)
            MultilineTextView(
                text: $model.space.title, model: self.model,
                textColor: UIColor(SolColor.colors().checkBox.doneBackground),
                textSize: 24, delegate: model)
                .font(SolFonts.font(
                        size: 24,
                        weight: Font.Weight.medium,
                        color: SolColor.colors().checkBox.doneBackground))
                .frame(width: .infinity, height: model.titleSize, alignment: .center)
                .foregroundColor(SolColor.colors().checkBox.doneBackground)

                           
//            TextField("Space title", text: $model.space.title)
//                .font(SolFonts.font(
//                        size: 24,
//                        weight: Font.Weight.medium,
//                        color: SolColor.colors().checkBox.doneBackground))
//                .frame(width: .infinity, height: model.calcTitleHeight(), alignment: .center)
//                .foregroundColor(SolColor.colors().checkBox.doneBackground)

            
            Spacer().frame(width: 8, height: 1, alignment: .center)
        })
    }
}

extension SpaceView {
    var actionsTitle:some View {
        VStack{
            Spacer().frame(width: 1, height: 16, alignment: .center)
            
            HStack(alignment: .center){
                Spacer()
                    .frame(width: 12, height: 0, alignment: .center)
                IconComponent(size: 24, icon: "⚙️")
                Spacer()
                    .frame(width: 8, height: 0, alignment: .center)
                Text("Actions")
                    .font(
                        SolFonts.font(
                            size: 24,
                            weight: Font.Weight.medium,
                            color: SolColor.colors().fontColors.normal))
                Spacer()
                Spacer().frame(width: 16, height: 0, alignment: .center)
            }
        }
    }
}

extension SpaceView {
    var headerSpacer: some View {
        HStack{
            Spacer()
                .frame(
                    width: .infinity,
                    height: (41 + 41 + 34),
                    alignment: .center)
        }
    }
}

extension SpaceView {
    var subtasks: some View {
        HStack{
            VStack {
                Spacer().frame(width: 1, height: 16, alignment: .center)
                TaskItemView()
                TaskItemView()
                TaskItemView()
                TaskItemView()
                TaskItemView()
                Spacer().frame(width: 1, height: 16, alignment: .center)
            }
        }
    }
}


struct SpaceView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceView(model: SpaceViewModel("1111"))
    }
}


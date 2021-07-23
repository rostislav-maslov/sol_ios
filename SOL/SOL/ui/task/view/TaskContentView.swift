//
//  TaskItemView.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import SwiftUI
import NavigationStack

struct TaskContentView: View {
    @State private var activeTab = 0
    private var activeTabMax = 3
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @State var actionToggle:Bool = false
    @State var actionRepeat:Bool = false
    @State var actionNotification = false
    @State var actionPlanning = false
    @State var actionDeadline = false
    @State var actionDone = false
    
    var body: some View {
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
                            
                            //self.goBack.ppp().wrappedValue.dismiss()
                            print("DragGesture")
                        }
                    }else{
                        if value.translation.width > .zero
                            && value.translation.height > -30
                            && value.translation.height < 30 {
                            if activeTab - 1 >= 0 {
                                activeTab = activeTab - 1
                            }
                            print(activeTab)
                            print(value.translation.width)
                        }else{
                            if activeTab + 1 <= activeTabMax {
                                activeTab = activeTab + 1
                            }
                            print(activeTab)
                            print(value.translation.width)
                        }
                    }
                }
        )
    }
}

extension TaskContentView {
    var picker: some View {
        HStack{
            Spacer().frame(width: 12, height: 1, alignment: .center)
            Picker(selection: $activeTab, label: Text("")) {
                Text("Tasks").tag(0)
                Text("Details").tag(1)
                Text("Files").tag(2)
                Text("Photo").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer().frame(width: 12, height: 1, alignment: .center)
        }
    }
    
    var pickerContainer: some View {
        VStack{
            if(activeTab == 0){
                subtasks
            }
            if(activeTab == 1){
                Text("Details")
            }
            if(activeTab == 2){
                Text("files")
            }
            if(activeTab == 3){
                Text("photo")
            }
            Spacer().frame(height: 142)
        }
    }
}

extension TaskContentView {
    var header: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            headerSpacer
            taskTitle
            Spacer().frame(width: 1, height: .infinity, alignment: .center)
        })
    }
}

extension TaskContentView {
    var actionToggleView: some View {
        VStack{
            if (actionToggle == false){
                ActionButtonView(
                    title: "Toggle",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_arrow-tab",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 16,
                    iconHeight: 16,
                    iconVerticalSpace: 4,
                    subTitle: "Show all subtask") {
                    self.actionToggle = !self.actionToggle
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
                    self.actionToggle = !self.actionToggle
                }
            }
        }
    }
    
    var repeatActionButton: some View {
        VStack{
            if (actionRepeat == false){
                ActionButtonView(
                    title: "Repeat",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "repeat",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Every monday"){
                    self.actionRepeat = !self.actionRepeat
                }
                
            }else {
                ActionButtonView(
                    title: "Repeat",
                    titleColor: SolColor.colors().checkBox.doneBackground,
                    icon: "repeat",
                    iconColor: SolColor.colors().checkBox.doneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Set repeat"){
                    self.actionRepeat = !self.actionRepeat
                }
            }
        }
    }
    
    var notificationActionView: some View {
        VStack{
            if (actionNotification == false){
                ActionButtonView(
                    title: "Notifications",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "notification",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "01/29/21 01:15PM"){
                    self.actionNotification = !self.actionNotification
                }
                
            }else {
                ActionButtonView(
                    title: "Notifications",
                    titleColor: SolColor.colors().checkBox.doneBackground,
                    icon: "notification",
                    iconColor: SolColor.colors().checkBox.doneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Add notifications"){
                    self.actionNotification = !self.actionNotification
                }
            }
        }
    }
    
    var planningActionView: some View {
        VStack{
            if (actionPlanning == false){
                ActionButtonView(
                    title: "Planning",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_calendar",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Your plan 4h"){
                    self.actionPlanning = !self.actionPlanning
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
                    self.actionPlanning = !self.actionPlanning
                }
            }
        }
    }
    
    var deadlineActionView: some View {
        VStack{
            if (actionDeadline == false){
                ActionButtonView(
                    title: "Deadline",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "deadline",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "01/18/2021"
                ){
                    self.actionDeadline = !self.actionDeadline
                }
                
            }else {
                ActionButtonView(
                    title: "Deadline",
                    titleColor: SolColor.colors().checkBox.doneBackground,
                    icon: "deadline",
                    iconColor: SolColor.colors().checkBox.doneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Set deadline"
                ){
                    self.actionDeadline = !self.actionDeadline
                }
            }
        }
    }
    
    var doneActionView: some View {
        VStack{
            if (actionDone == false){
                ActionButtonView(
                    title: "Done",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_check_undone",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Make task done"
                ){
                    self.actionDone = !self.actionDone
                }
                
            }else {
                ActionButtonView(
                    title: "Done",
                    titleColor: SolColor.colors().actionButton.taskDone,
                    icon: "ic_check_done",
                    iconColor: SolColor.colors().actionButton.taskDone,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Go back to work"
                ){
                    self.actionDone = !self.actionDone
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
                        doneActionView
                        actionToggleView
                    }
                    VStack {
                        planningActionView
                        notificationActionView
                    }
                    VStack {
                        repeatActionButton
                        deadlineActionView
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

extension TaskContentView {
    var taskTitle: some View {
        
        HStack(alignment: .top, spacing: 0, content: {
            Spacer().frame(width: 16, height: 11, alignment: .center)
            VStack{
                Spacer().frame(width: 0, height: 4, alignment: .center)
                CheckBoxView(size: .NORMAL, done: $actionDone)
            }
            Spacer().frame(width: 8, height: 1, alignment: .center)
            Text("😂 Сделать суперсложный и супербольшой очет, очень горит.")
                .font(
                    SolFonts.font(
                        size: 24,
                        weight: Font.Weight.medium,
                        color: SolColor.colors().checkBox.doneBackground))
                .foregroundColor(SolColor.colors().checkBox.doneBackground)
                .strikethrough(self.actionDone, color: SolColor.colors().checkBox.doneBackground)
                //.frame(maxWidth: .infinity, alignment: .center)
                .frame(width: .infinity, height: 24 * 3 + 5 * 3, alignment: .center)
            
            Spacer().frame(width: 8, height: 1, alignment: .center)
        })
    }
}

extension TaskContentView {
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

extension TaskContentView {
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

extension TaskContentView {
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


struct TaskContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskContentView()
    }
}

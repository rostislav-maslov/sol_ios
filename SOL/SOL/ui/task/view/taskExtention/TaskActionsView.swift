//
//  TaskActionsView.swift
//  SOL
//
//  Created by Rostislav Maslov on 12.08.2021.
//

import Foundation
import SwiftUI

extension TaskView{
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
                    model.actionToggle = !model.actionToggle
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
                    model.actionToggle = !model.actionToggle
                }
            }
        }
    }
    
    var repeatActionButton: some View {
        VStack{
            if (model.actionRepeat == false){
                ActionButtonView(
                    title: "Repeat",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "repeat",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Every monday"){
                    model.actionRepeat = !model.actionRepeat
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
                    model.actionRepeat = !model.actionRepeat
                }
            }
        }
    }
    
    var notificationActionView: some View {
        VStack{
            if (model.actionNotification == false){
                ActionButtonView(
                    title: "Notifications",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "notification",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "01/29/21 01:15PM"){
                    model.actionNotification = !model.actionNotification
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
                    model.actionNotification = !model.actionNotification
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
                    model.actionPlanning = !model.actionPlanning
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
                    model.actionPlanning = !model.actionPlanning
                }
            }
        }
    }
    
    var deadlineActionView: some View {
        VStack{
            if (model.actionDeadline == false){
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
                    model.actionDeadline = !model.actionDeadline
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
                    model.actionDeadline = !model.actionDeadline
                }
            }
        }
    }
    
    var doneActionView: some View {
        VStack{
            if (taskStore.tasks[taskId]?.status == .OPEN){
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
                    model.toggleTask()
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
                    model.toggleTask()
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

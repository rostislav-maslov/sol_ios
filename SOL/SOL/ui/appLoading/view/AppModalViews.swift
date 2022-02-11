//
//  AppModalViews.swift
//  SOL
//
//  Created by Rostislav Maslov on 20.10.2021.
//

import SwiftUI

struct AppModalViews: View {
    @Binding var goToState: AppLoadingState?
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var slotStore: SlotStore
    @EnvironmentObject var spaceStore: SpaceStore
    var body: some View {
        ZStack{
            if goToState == .SPACES {
                AddTaskRootView()
                PlanningSlotsView(model: planningSlotsModel)
                ViewFiltersModal()
                ViewDisplayModeModel()
                ViewSortModal()
                
                /// Edit View
                ZStack{
                    ZStack{
                        ViewTypeChooseSheet()
                        DisplayModeChooseSheet()
                        AddedTypeChooseSheet()
                        SortChooseSheet()
                        SlotChooseSheet()
                        NotificationChooseSheet()
                    }
                    ZStack{
                        RepeatChooseSheet()
                        OverdueChooseSheet()
                        TaskIdClosedChooseSheet()
                        DeadlineDidChangeSheet()
                        DeadlineExactDateSheet()
                        DeadlineRelativeChooseSheet()
                        SpaceChooseSheet()
                        ChooseParamSheet()
                        SorrySheet()
                    }
                }
            }
        }.onAppear {
            planningSlotsModel.taskStore = taskStore
            planningSlotsModel.spaceStore = spaceStore
            planningSlotsModel.slotStore = slotStore
        }
    }
}



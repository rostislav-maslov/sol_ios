//
//  ChooseEventTimeComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.06.2021.
//

import SwiftUI
import EventKit
import EventKitUI
import UIKit
import BottomSheet

struct PlanningSlotsView: View, DaySchedulerProtocol{

    let delegate: DaySchedulerProtocol    
        
    @State var state = ViewState.NORMAL
    @Binding var isPresented: Bool
    var type: PlanningType
    
    @ObservedObject var model: PlanningSlotsModel = PlanningSlotsModel()
    
    @State var canGoToTask: Bool = false
    @State var title: String = ""
    @State var slotId: String = ""
    @State var spaceId: String = ""
    @State var taskId: String = ""
    
    @ObservedObject var modalViewModel: PlanningSlotModel = PlanningSlotModel(slot: SlotEntity(), task: TaskEntity())
    @State var showPlanningSlot: Bool = false
    
    @ObservedObject var planningSlotModel: PlanningSlotModel = PlanningSlotModel(slot: SlotEntity(), task: TaskEntity())
    @EnvironmentObject var taskStore: TaskStore
    var body: some View {
        ZStack{
            Text("")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: Alignment.center)
                .bottomSheet(
                    isPresented: $isPresented,
                    height: UIScreen.main.bounds.height - 50,
                    topBarHeight: 0,
                    topBarCornerRadius: 16,
                    contentBackgroundColor: SolColor.colors().addTask.addTaskBackground,
                    topBarBackgroundColor: SolColor.colors().addTask.addTaskBackground,
                    showTopIndicator: false,
                    content: {
                        ZStack{
                            //backgroundView
                            day
                            closeButton
                            submitButton
                        }
                    })
            
            Text("")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: Alignment.center)
                .bottomSheet(
                    isPresented: $showPlanningSlot,
                    height: 300) {
                        PlanningSlotModalView(
                            canGoToTask: $canGoToTask,
                            title: $title,
                            slotId: $slotId,
                            spaceId: $spaceId,
                            taskId: $taskId) {
                                delegate.onDelete(slotId: slotId)
                                showPlanningSlot = false
                            }
                }
            
        }
        .ignoresSafeArea()
        .frame(
            width: UIScreen.main.bounds.width,
            height: self.isPresented ? UIScreen.main.bounds.height : 0,
            alignment: Alignment.center)                        
    }
    
}

extension PlanningSlotsView{
    var backgroundView: some View {
        VStack{
            Rectangle()
                .fill(SolColor.colors().addTask.addTaskBackground)
                .cornerRadius(12, corners: [.topLeft, .topRight])
                .frame(width: .infinity, height: 102, alignment: .center)
            Spacer()
        }
        
    }
}

extension PlanningSlotsView{
    var backgroundBottomView: some View {
        VStack{
            Spacer()
            Rectangle()
                .fill(SolColor.colors().addTask.addTaskBackground)
                .cornerRadius(12, corners: [.topLeft, .topRight])
                .frame(width: .infinity, height: 102, alignment: .center)
                
            .ignoresSafeArea()
        }
        
    }
}

extension PlanningSlotsView{
    var day: some View {
        VStack{
            Spacer()
                .frame(width: 0, height: 16, alignment: .center)
            Text("Plan your work at task")
            Spacer()
                .frame(width: 0, height: 12, alignment: .center)
                .background(SolColor.colors().addTask.addTaskBackground)
                .frame(width: nil, height: 24, alignment: .center)
            Spacer()
                .frame(width: 0, height: 0, alignment: .center)
            
            DaySchedulerView(
                delegate: self)
                                    
            Spacer()
                .frame(width: 0, height: 0, alignment: .center)
        }
        //.background(SolColor.colors().addTask.addTaskBackground)
    }
}

extension PlanningSlotsView{
    var closeButton: some View{
        VStack{
            Spacer().frame(width: 0, height: ( 16), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            HStack{
                Spacer()
                Button(action: {
                    onClose()
                }, label: {
                    ZStack{
                        Image("ic_close")
                            .frame(width: 24, height: 24, alignment: .center)
                    }
                    
                })
                Spacer().frame(width: 16, height: 0, alignment: .center)
            }
            Spacer()
        }
    }
    
}

extension PlanningSlotsView{
    var submitButton: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
                ButtonComponent(
                    title: "Submit",
                    state: $state,
                    action: {
                        onSubmit()
                    })
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
            }
            
            Spacer().frame(width: 0, height: 56 , alignment: .center)
        }
    }
}

extension  PlanningSlotsView {
    func newSlotName() -> String {
        return delegate.newSlotName()
    }
    
    func slotsByDay(date: Date, callback: @escaping (([SlotEntity]) -> Void)) {
        return delegate.slotsByDay(date: date, callback: callback)
    }
    
    func addSlot(startTime: Date, endTime: Date) {
        delegate.addSlot(startTime: startTime, endTime: endTime)
    }
    
    func changeTimeSlot(slotId: String, startTime: Date, endTime: Date) {
        delegate.changeTimeSlot(slotId: slotId, startTime: startTime, endTime: endTime)
    }
    
    func onClose() {
        delegate.onClose()
        isPresented = false
    }
    
    func onSubmit() {
        delegate.onSubmit()
        isPresented = false
    }
    
    func onTapEvent(slot: SlotEntity) {
        
        canGoToTask = type == .VIEW
        title = slot.title
        slotId = slot.id
        taskId = slot.createdFromTaskId != nil ? slot.createdFromTaskId! : ""
        spaceId = "" // TODO: тут понять откуда лучше брать spaceId
        
        modalViewModel.slot = slot
        showPlanningSlot = true
    }
    
    func onDelete(slotId: String) {
        delegate.onDelete(slotId: slotId)
    }
}

//struct ChooseEventTimeComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseEventTimeComponent(model: AddTaskViewModel("", parentTaskId: ""))
//    }
//}

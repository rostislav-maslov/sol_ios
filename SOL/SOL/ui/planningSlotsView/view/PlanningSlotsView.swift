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

struct PlanningSlotsView: View{

    @Binding var isPresented: Bool
    var type: PlanningType
    var delegate: DaySchedulerProtocol
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var slotStore: SlotStore
    
    
    @StateObject var model: PlanningSlotsModel = PlanningSlotsModel()
    @StateObject var planningSlotModel: PlanningSlotModel = PlanningSlotModel(slot: SlotEntity(), task: TaskEntity())
            
    
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
                    isPresented: $model.showPlanningSlot,
                    height: 300) {
                        PlanningSlotModalView(
                            canGoToTask: $model.canGoToTask,
                            title: $model.title,
                            slotId: $model.slotId,
                            spaceId: $model.spaceId,
                            taskId: $model.taskId) { slotToDeleteId in
                                model.deleteSlot(slotToDeleteId: slotToDeleteId)                                
                            }
                }
        }
        .onAppear(perform: {
            model.slotStore = slotStore
            model.type = type
            model.delegate = delegate
            model.needClose = needClose
        })
        .ignoresSafeArea()
        .frame(
            width: UIScreen.main.bounds.width,
            height: self.isPresented ? UIScreen.main.bounds.height : 0,
            alignment: Alignment.center)                        
    }
    
    
    func needClose() {
        isPresented = false
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
            DaySchedulerView(delegate: self.model, needUpdate: $model.needUpdate)
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
                    model.onClose()
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
                    state: $model.state,
                    action: {
                        model.onSubmit()
                    })
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
            }
            
            Spacer().frame(width: 0, height: 56 , alignment: .center)
        }
    }
}

extension  PlanningSlotsView {
   
}

//struct ChooseEventTimeComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseEventTimeComponent(model: AddTaskViewModel("", parentTaskId: ""))
//    }
//}

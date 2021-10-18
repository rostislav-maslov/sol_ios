//
//  PlanningSlotModalView.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.10.2021.
//

import SwiftUI

struct PlanningSlotModalView: View {
    @Binding var canGoToTask: Bool
    
    //@ObservedObject var model: PlanningSlotModel
    @Binding var title: String
    @Binding var slotId: String
    @Binding var spaceId: String
    @Binding var taskId: String
    
    @State var goToTaskView: Bool = false
    @State var buttonState: ViewState = ViewState.NORMAL
    
    @EnvironmentObject var taskStore: TaskStore
    
    var onDelete: ((_ slotId: String) -> Void)
    
    var body: some View {
        VStack{
            
            HStack{
                Text(title)
                    .font(SolFonts.font(size: 24, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                    .foregroundColor(SolColor.colors().fontColors.normal)
                Spacer()
            }
            
            Spacer().frame(width: 0, height: 20, alignment: Alignment.center)
            
            HStack{
                if canGoToTask == false && false {
                    Text("Это черновик, в задачу нельзя перейти =(")
                }else{
                    if taskId != "" {
                        NavigationLink(destination: TaskView(spaceId: spaceId, taskId: taskId), isActive: $goToTaskView) {
                            EmptyView()
                        }
                    }
                                        
                    ButtonComponent(title: "Нажми что бы перейти на экран задачи", state: $buttonState) {
                        goToTaskView = true
                        //taskStore.syncTask(taskId: taskId)
                    }
                }
                
                ButtonComponent(title: "Remove Slot", state: $buttonState) {
                    onDelete(slotId)
                }
                
                Spacer()
            }
            Spacer()
        }.padding()            
            .onAppear {
                print("new task id - \(taskId)")
            }
        
    }
}

//struct PlanningSlotModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanningSlotModalView()
//    }
//}

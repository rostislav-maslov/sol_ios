//
//  PlanningSlotModalView.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.10.2021.
//

import SwiftUI
import Combine

struct SlotModalView: View {
    
    @ObservedObject var model: SlotModel
    var onDelete: ((_ slotId: String) -> Void)
    @State var buttonState: ViewState = .NORMAL
    @EnvironmentObject var taskStore: TaskStore
    
    var body: some View {
        VStack{
            if model.slot != nil {
                content.onAppear {
                    print("new task id - ")
                }
            }
        }        
        .onAppear {
            print("new task id - ")
        }
    }
    
    var content: some View {
        VStack{
            HStack{
                if model.slot?.isDraft == false {
                    Text(taskStore.tasks[model.taskId!]!.fullTitle)
                        .font(SolFonts.font(size: 24, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                        .foregroundColor(SolColor.colors().fontColors.normal)
                }else{
                    Text(model.slot!.title)
                        .font(SolFonts.font(size: 24, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
                        .foregroundColor(SolColor.colors().fontColors.normal)
                }
                Spacer()
            }
            
            Spacer().frame(width: 0, height: 20, alignment: Alignment.center)
            
            HStack{
                if model.canGoToTask == false && false {
                    Text("Это черновик, в задачу нельзя перейти =(")
                }else{
//                    if model.task != nil {
                        //                        NavigationLink(destination: TaskView(spaceId: spaceId, taskId: taskId), isActive: $goToTaskView) {
                        //                            EmptyView()
                        //                        }
//                    }
                    
//                    ButtonComponent(title: "Нажми что бы перейти на экран задачи", state: $buttonState) {
//                        //TODO переход сделать
//                        //goToTaskView = true
//                        //taskStore.syncTask(taskId: taskId)
//                    }
                }
                
                
                
                Spacer()
            }
            Spacer()
            HStack(alignment: .center){
                Spacer()
                Button {
                    onDelete(model.slot!.id)
                } label: {
                    Text("Remove Slot")
                        .foregroundColor(SolColor.colors().fontColors.dangerous)
                        .font(SolFonts.font(size: 14, weight: Font.Weight.regular, color: SolColor.colors().fontColors.dangerous))
                }.buttonStyle(.plain)
                Spacer()
            }
            Spacer().frame(width: 0, height: 0, alignment: .center)
        }.padding()
    }
}

//struct PlanningSlotModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanningSlotModalView()
//    }
//}

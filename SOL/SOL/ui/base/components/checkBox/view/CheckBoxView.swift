//
//  CheckBoxView.swift
//  SOL
//
//  Created by Rostislav Maslov on 17.07.2021.
//

import SwiftUI

public enum CheckBoxSize {
    case NORMAL
    case BIG
}

struct CheckBoxView: View {
    var taskId: String
    var size:CheckBoxSize
    @EnvironmentObject var taskStore: TaskStore
    
    public init(taskId: String, size:CheckBoxSize){
        self.size = size
        self.taskId = taskId
    }
        
    var body: some View {
        Button(action: {
            self.taskStore.changeStatus(taskId: taskId)
            UINotificationFeedbackGenerator.generate(.TASK_DONE)
        }, label: {
            ZStack{
                undoneImage
                if (taskStore.tasks[taskId]?.status == .DONE ) {
                    doneImage
                }
            }
        })                
    }
}

extension CheckBoxView{
    var undoneImage: some View {
        Image("ic_check_undone")
            .resizable()
            .renderingMode(.template)
            .frame(
                width: (self.size == .NORMAL ? 24 : 48),
                height: (self.size == .NORMAL ? 24 : 48),
                alignment: .center)
            .foregroundColor(
                taskStore.tasks[taskId]?.status == .DONE ?
                    SolColor.colors().checkBox.doneBackground :
                    SolColor.colors().checkBox.undoneBackground
            )
            .scaledToFill()
    }
}

extension CheckBoxView {
    var doneImage: some View {
        Image("ic_check_done")
            .resizable()
            .renderingMode(.template)
            .frame(
                width: (self.size == .NORMAL ? 12 : 16),
                height: (self.size == .NORMAL ? 8 : 12),
                alignment: .center)
            .foregroundColor(
                taskStore.tasks[taskId]?.status == .OPEN ?
                    SolColor.colors().checkBox.doneBackground :
                    SolColor.colors().checkBox.undoneBackground
            )
            .scaledToFill()
    }
}

//struct CheckBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckBoxView(size: .BIG, done: Binding<Bool>(get: {
//            return true
//
//        }, set: { ssss in
//
//        })) {
//
//        }
//    }
//}

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

struct PlanningSlotsView: View {
    let delegate: DaySchedulerProtocol
    @State var state = ViewState.NORMAL
    
    var body: some View {
        ZStack{
            backgroundView
            day
            closeButton
            submitButton
        }        
        .ignoresSafeArea()
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
                .frame(width: .infinity, height: 24, alignment: .center)
            Spacer()
                .frame(width: 0, height: 0, alignment: .center)
            
            DaySchedulerView(delegate: delegate)
            
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
                    delegate.onClose()                    
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
                    action: self.delegate.onSubmit)
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
            }
            
            Spacer().frame(width: 0, height: 56 , alignment: .center)
        }
    }
}

//struct ChooseEventTimeComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseEventTimeComponent(model: AddTaskViewModel("", parentTaskId: ""))
//    }
//}

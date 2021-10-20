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
import Combine

struct PlanningSlotsView: View{
    
    @ObservedObject var model: PlanningSlotsModel
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var slotStore: SlotStore
    @EnvironmentObject var spaceStore: SpaceStore
        
    var onClose: ((_ drafts: [SlotEntity]) -> Void)?
    
    func close() {
        model.onSubmit()
        onClose?(model.drafts)
        model.clear()
    }
    
    var body: some View {
        
        ZStack{
            
            
        }
        .frame(width: nil, height: 0, alignment: Alignment.center)
        .bottomSheet(
            isPresented: $model.isPresented,
            height: UIScreen.main.bounds.height - 80,
            topBarHeight: 20,
            topBarCornerRadius: 16,
            contentBackgroundColor: SolColor.colors().addTask.addTaskBackground,
            topBarBackgroundColor: SolColor.colors().addTask.addTaskBackground,
            showTopIndicator: false) {
                VStack{
                    Spacer()
                        .frame(width: 0, height: 0, alignment: .center)
                    titleView
                    Spacer()
                        .frame(width: 0, height: 0, alignment: .center)
                    day
                    Spacer().frame(width: 0, height: 0, alignment: .center)
                }
            }
        .bottomSheet(
            isPresented: Binding(get: {
              return model.slotModel.isPresented
            }, set: { newVal in
                model.slotModel.isPresented = newVal
                if newVal == false {
                    model.isPresented = true
                }                
            }),
                height: 300) {
                    SlotModalView(model: model.slotModel) { slotId in
                        model.deleteSlot(slotToDeleteId: slotId)
                    }
                }.onDisappear {
                    print("did close")
                }
                .colorScheme(ColorScheme.light)
                .onAppear(perform: {
                    model.slotStore = slotStore
                    model.taskStore = taskStore
                    model.spaceStore = spaceStore
                })
    }
}

extension PlanningSlotsView{
    var titleView: some View {
        ZStack {           
            Text(model.title)
                .font(SolFonts.font(size: 18, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                .foregroundColor(SolColor.colors().fontColors.normal)
            closeButton
        }.frame(width: nil, height: 54, alignment: .center)
    }
    
}

extension PlanningSlotsView{
    var day: some View {
        VStack{
            Spacer()
                .frame(width: nil, height: 0, alignment: .center)
            DaySchedulerView(model: model)
            Spacer()
                .frame(width: 0, height: 0, alignment: .center)
            bottom
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
                    close()
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
    var bottom: some View {
        VStack{
            Spacer().frame(width: nil, height: 16, alignment: .center)
            HStack{
                Spacer().frame(width: 16, height: 0)
                Button {
                    model.dayViewControllerImpl.move(to: Date())
                } label: {
                    Text("Today")
                        .font(SolFonts.font(size: 16, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                        .foregroundColor(SolColor.colors().fontColors.normal)
                }.buttonStyle(.plain)
                Spacer()
                Button {
                    close()
                } label: {
                    Text("Close")
                        .font(SolFonts.font(size: 16, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                        .foregroundColor(SolColor.colors().fontColors.normal)
                }.buttonStyle(.plain)
                Spacer().frame(width: 16, height: 0)
            }
            Spacer().frame(width: nil, height: 16, alignment: .center)
        }
        .background(SolColor.colors().addTask.addTaskBackground)
    }
}


extension  PlanningSlotsView {
    
}

//struct ChooseEventTimeComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseEventTimeComponent(model: AddTaskViewModel("", parentTaskId: ""))
//    }
//}

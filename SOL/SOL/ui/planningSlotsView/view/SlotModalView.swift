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
    
    @State var showingAlert = false
    @State var goToTaskView = false
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
            header
            Spacer().frame(width: 0, height: 16, alignment: Alignment.center)
            HStack{
                Spacer().frame(width: 0, height: 16, alignment: Alignment.center)
                Rectangle()
                    .foregroundColor(SolColor.colors().taskLine.divider)
                    .frame(width: nil, height: 1, alignment: .center)
            }
            createdFromTask
            editSlot
            Spacer()
            bottom
            Spacer().frame(width: 0, height: 0, alignment: .center)
        }.padding()
    }
}

extension SlotModalView {
    var header: some View {
        VStack{
            HStack{
                if model.taskId != nil && model.slot?.isDraft == false && taskStore.tasks[model.taskId!] != nil {
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
            Spacer().frame(width: 0, height: 8, alignment: Alignment.center)
            HStack{
                Text(model.slot!.dayInfo)
                    .font(SolFonts.font(size: 14, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                    .foregroundColor(SolColor.colors().fontColors.second)
                Spacer()
            }
            Spacer().frame(width: 0, height: 4, alignment: Alignment.center)
            HStack{
                Text(model.slot!.timeInfo)
                    .font(SolFonts.font(size: 14, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                    .foregroundColor(SolColor.colors().fontColors.second)
                Spacer()
            }
        }
    }
}

extension SlotModalView {
    var createdFromTask: some View {
        VStack {
            Spacer().frame(width: 0, height: 4, alignment: Alignment.center)
            if model.canGoToTask == true {
                Button {
                    taskStore.syncTask(taskId: model.taskId!)
                    goToTaskView = true
                } label: {
                    HStack{
                        Text("Event created from task")
                            .font(SolFonts.font(size: 14, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                            .foregroundColor(SolColor.colors().fontColors.normal)
                        Spacer()
                        Text("Go to task")
                            .font(SolFonts.font(size: 10, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                            .foregroundColor(SolColor.colors().fontColors.second)
                        Spacer().frame(width: 0, height: 0, alignment: .center)
                        
                    }
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $goToTaskView) {
                    print("dfdf")
                } content: {
                    VStack{
                        Spacer().frame(width: 0, height: 16, alignment: .center)
                        HStack(alignment: VerticalAlignment.center, spacing: 0, content: {
                            Spacer().frame(width: 16, height: 0, alignment: .center)
                            Spacer()
                            Rectangle()
                                .frame(width: 40, height: 6, alignment: Alignment.center)
                                .cornerRadius(3)
                                .foregroundColor(SolColor.colors().fontColors.normal)
                            Spacer()
                            Spacer().frame(width: 16, height: 0, alignment: .center)
                        })
                        Spacer().frame(width: 0, height: 16, alignment: .center)
                        TaskView(spaceId: model.spaceId ?? "", taskId: model.taskId ?? "")
                        HStack(alignment: VerticalAlignment.center, spacing: 0, content: {
                            Button {
                                goToTaskView = false
                            } label: {
                                Text("Close")
                                    .font(SolFonts.font(size: 16, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                                    .foregroundColor(SolColor.colors().fontColors.normal)
                            }

                            Spacer().frame(width: 16, height: 0, alignment: .center)
                        })
                        Spacer().frame(width: 16, height: 0, alignment: .center)
                    }.background(SolColor.colors().screen.background)
                }
                Spacer().frame(width: 0, height: 4, alignment: Alignment.center)
                HStack{
                    Spacer().frame(width: 0, height: 16, alignment: Alignment.center)
                    Rectangle()
                        .foregroundColor(SolColor.colors().taskLine.divider)
                        .frame(width: nil, height: 1, alignment: .center)
                }
            }
        }
    }
}

extension SlotModalView {
    var editSlot: some View {
        Button {
            showingAlert = true
        } label: {VStack {
            Spacer().frame(width: 0, height: 4, alignment: Alignment.center)
            HStack{
                Text("Edit event")
                    .font(SolFonts.font(size: 14, weight: Font.Weight.regular, color: SolColor.colors().fontColors.normal))
                    .foregroundColor(SolColor.colors().fontColors.normal)
                Spacer()
            }
            Spacer().frame(width: 0, height: 4, alignment: Alignment.center)
            HStack{
                Spacer().frame(width: 0, height: 16, alignment: Alignment.center)
                Rectangle()
                    .foregroundColor(SolColor.colors().taskLine.divider)
                    .frame(width: nil, height: 1, alignment: .center)
            }
        }
        }.alert("Нужно задизайнить экран редактирования слота", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        
    }
}

extension SlotModalView {
    var bottom: some View {
        VStack{
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
        }
    }
}

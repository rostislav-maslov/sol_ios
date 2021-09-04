//
//  TaskItemView.swift
//  SOL
//
//  Created by Rostislav Maslov on 20.07.2021.
//

import SwiftUI
import NavigationStack

struct TaskItemView: View {
    @ObservedObject  var model: TaskItemViewModel
    @State var target: Bool = true
    var body: some View {
        VStack{
            Spacer()
                .frame(width: 1, height: 8, alignment: .center)
            HStack{
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
                containerBackground
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
            }
            Spacer()
                .frame(width: 1, height: 8, alignment: .center)
//                        doneLine            
        }
        
    }
}

extension TaskItemView {
    var containerBackground: some View {
        HStack{
            Spacer().frame(width: 8)
            VStack{
                defaultLine
            }
            Spacer().frame(width: 8)
        }
        .background(SolColor.colors().taskLine.container)
        .cornerRadius(12)
    }
}

extension TaskItemView{
    var defaultLine: some View {
        VStack{
            HStack(alignment: .top, spacing: 0, content: {
                Button(action: {
                    print("done")
                }, label: {
                    VStack{
                        Spacer().frame(height: 12)
                        HStack{
                            Spacer().frame(width: 6)
                            Image("ic_check_undone")
                                .resizable()
                                .renderingMode(.template)
                                .frame(
                                    width: 18,
                                    height: 18,
                                    alignment: .center)
                                .foregroundColor(
                                    SolColor.colors().checkBox.undoneBackground
                                )
                                .scaledToFill()
                            Spacer().frame(width: 4)
                        }
                        Spacer().frame(height: 12)
                    }
                })
                PushView(
                    destination: TaskView(model: TaskViewModel(task: self.model.task)),
                    label: {
                        VStack{
                            Spacer().frame(height: 8)
                            HStack{
                                Spacer().frame(width: 4)
                                Text(model.task.fullTitle())
                                    .font(
                                        SolFonts.font(
                                            size: 16,
                                            weight: Font.Weight.regular,
                                            color: SolColor.colors().fontColors.normal))
                                    .foregroundColor(SolColor.colors().fontColors.normal)
                                Spacer().frame(
                                    minWidth: 0,
                                    idealWidth: 0,
                                    maxWidth: 0,
                                    minHeight: 25,
                                    idealHeight: 25,
                                    maxHeight: 25,
                                    alignment: .center)
                                Spacer()
                            }.frame(width: .infinity)
                            Spacer().frame(height: 8)
                        }.background(SolColor.colors().taskLine.container)
                    })
                    .buttonStyle(PlainButtonStyle())
                VStack{
                    if self.model.task.hasChild == true {
                        Button(action: {
                            print("ic_task_item_expand")
                        }, label: {
                            VStack{
                                Spacer().frame(height: 19)
                                HStack{
                                    Spacer().frame(width: 8)
                                    Image("ic_task_item_expand")
                                        .frame(
                                            width: 12,
                                            height: 6,
                                            alignment: .center)
                                    Spacer().frame(width: 8)
                                }
                                Spacer().frame(height: 14)
                            }
                        })
                    }
                }
            })
        }
    }
}

extension TaskItemView{
    var doneLine: some View {
        HStack{
            Spacer()
                .frame(width: 24, height: 0, alignment: .center)
            Image("ic_check_done")
                .resizable()
                .renderingMode(.template)
                .frame(
                    width: 12,
                    height: 8,
                    alignment: .center)
                .foregroundColor(
                    SolColor.colors().checkBox.doneBackground
                )
                .scaledToFill()
            Spacer()
                .frame(width: 8, height: 0, alignment: .center)
            PushView(
                destination: TaskView(model: TaskViewModel(task: TaskEntity.forRender())),
                label: {
                    HStack{
                        Text("🤧")
                            .font(
                                SolFonts.font(
                                    size: 16,
                                    weight: Font.Weight.medium,
                                    color: SolColor.colors().fontColors.normal))
                            .strikethrough(true, color: SolColor.colors().checkBox.doneBackground)
                        Spacer().frame(width: 4)
                        Text("My first task")
                            .font(
                                SolFonts.font(
                                    size: 16,
                                    weight: Font.Weight.medium,
                                    color: SolColor.colors().checkBox.doneBackground))
                            .strikethrough(true, color: SolColor.colors().checkBox.doneBackground)
                            .foregroundColor(SolColor.colors().checkBox.doneBackground)
                    }
                })
                .buttonStyle(PlainButtonStyle())
            
            Spacer()
            Spacer().frame(width: 16, height: 0, alignment: .center)
        }
    }
}

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(model: TaskItemViewModel(task: TaskEntity.forRender()))
    }
}

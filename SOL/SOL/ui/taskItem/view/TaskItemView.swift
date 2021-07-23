//
//  TaskItemView.swift
//  SOL
//
//  Created by Rostislav Maslov on 20.07.2021.
//

import SwiftUI
import NavigationStack

struct TaskItemView: View {
    @ObservedObject  var model: TaskItemViewModel = TaskItemViewModel()
    
    var body: some View {
        VStack{
            Spacer().frame(width: 1, height: 16, alignment: .center)
            HStack{
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
                containerBackground
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
            }
            
            //            doneLine
            
        }
        .background(SolColor.colors().screen.background)
    }
}

extension TaskItemView {
    var containerBackground: some View {
        HStack{
            Spacer().frame(width: 8)
            VStack{
                Spacer().frame(height: 16)
                defaultLine
                HStack{
                    Spacer().frame(width: 0)
                    Image("ic_arrow-tab")
                        .frame(width: 16, height: 15, alignment: .center)
                    Spacer().frame(width: 12)
                    Spacer().frame(width: 0)
                    VStack{
                        defaultLine
                        HStack{
                            Spacer().frame(width: 0)
                            Image("ic_arrow-tab")
                                .frame(width: 16, height: 15, alignment: .center)
                            //Spacer().frame(width: 12)
                            Spacer().frame(width: 0)
                            doneLine
                        }
                    }
                    
                }
                Spacer().frame(height: 16)
            }
            Spacer().frame(width: 8)
        }
        .background(SolColor.colors().taskLine.container)
        .cornerRadius(12)
    }
}

extension TaskItemView{
    var defaultLine: some View {
        HStack{
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
            Spacer()
                .frame(width: 8, height: 0, alignment: .center)
            PushView(
                destination: TaskView(),
                label: {
                    HStack{
                        Text("🤧")
                            .font(
                                SolFonts.font(
                                    size: 16,
                                    weight: Font.Weight.medium,
                                    color: SolColor.colors().fontColors.normal))
                        Spacer().frame(width: 4)
                        Text("My first task")
                            .font(
                                SolFonts.font(
                                    size: 16,
                                    weight: Font.Weight.medium,
                                    color: SolColor.colors().fontColors.normal))
                            .foregroundColor(SolColor.colors().fontColors.normal)
                    }
                })
                .buttonStyle(PlainButtonStyle())
            
            Spacer()
            Spacer().frame(width: 16, height: 0, alignment: .center)
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
                destination: TaskView(),
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
        TaskItemView()
    }
}

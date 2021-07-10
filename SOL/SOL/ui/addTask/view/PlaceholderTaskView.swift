//
//  PlaceholderTaskComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.06.2021.
//

import SwiftUI

struct PlaceholderTaskView: View {
    @ObservedObject var model: AddTaskViewModel
    
    var body: some View {
        VStack{
            HStack{
                textComponent
                Spacer().frame(width: 0, height: 0, alignment: .center)
                voiceComponent
            }
            Spacer().frame(width: 0, height: 16, alignment: .center)
        }
    }
}

extension PlaceholderTaskView{
    var textComponent: some View {
        ZStack{
            Rectangle()
                .fill(SolColor.colors().addTask.placeholderBackground)
                .cornerRadius(8)
                .frame(width: .infinity, height: 48, alignment: .center)
                .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
            HStack{
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
                Image("ic_add_icon")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Text(model.task.title == "" ? "Add Task": model.task.title)
                    .font(SolFonts.font(
                        size: 16,
                        weight: Font.Weight.medium,
                        color:
                            model.task.title == "" ?
                            SolColor.colors().addTask.placeholderTextDefault :
                            SolColor.colors().addTask.placeholderTextFill
                    ))
                    .foregroundColor(
                        model.task.title == "" ? SolColor.colors().addTask.placeholderTextDefault : SolColor.colors().addTask.placeholderTextFill
                    )
                Spacer()
            }
            Button(action: self.model.goToText, label: {
                Rectangle()
            })
            .foregroundColor(.clear)
            .frame(width: .infinity, height: 48, alignment: .center)
        }
    }
}

extension PlaceholderTaskView{
    var voiceComponent: some View {
        ZStack{
            Rectangle()
                .fill(SolColor.colors().addTask.placeholderBackground)
                .cornerRadius(8)
                .frame(width: 48, height: 48, alignment: .center)
                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 8.0))
            Image("mic")
                .frame(width: 48, height: 48, alignment: .center)
                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 8.0))
            Button(action: self.model.goToText, label: {
                Rectangle()
            })
            .foregroundColor(.clear)
            .frame(width: 48, height: 48, alignment: .center)
        }
    }
}


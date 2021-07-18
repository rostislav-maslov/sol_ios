//
//  TaskItemView.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import SwiftUI
import NavigationStack

struct TaskContentView: View {
    @State private var favoriteColor = 0
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            header           
            actionsTitle
            actionsButton
            picker

        }
        .background(SolColor.colors().screen.background)
        .ignoresSafeArea(.all)
        .gesture(
            DragGesture(coordinateSpace: .local)
                .onEnded { value in
                    if value.startLocation.x > .zero && value.startLocation.x < 48{
                        if value.translation.width > .zero
                            && value.translation.height > -30
                            && value.translation.height < 30 {
                            self.navigationStack.pop()                            
                            
                            //self.goBack.ppp().wrappedValue.dismiss()
                            print("DragGesture")
                        }
                    }
                }
        )
    }
}

extension TaskContentView {
    var picker: some View {
        HStack{
            Spacer().frame(width: 12, height: 1, alignment: .center)
            Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                Text("Tasks").tag(0)
                Text("Details").tag(1)
                Text("Files").tag(2)
                Text("Photo").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
                        HStack{
                            PushView(
                                destination: TaskView(),
                                label: {            
                                    Text("sdfsd")
                                }).buttonStyle(PlainButtonStyle())
            
                        }.frame(height: 100)
            Spacer().frame(width: 12, height: 1, alignment: .center)
        }
        
    }
}

extension TaskContentView {
    var header: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            headerSpacer
            taskTitle
            Spacer().frame(width: 1, height: .infinity, alignment: .center)
        })
    }
}

extension TaskContentView {
    var actionsButton: some View {
        VStack{
            Spacer().frame(width: 1, height: 16, alignment: .center)
            CommandMenuComponent()
            Spacer().frame(width: 1, height: 16, alignment: .center)
        }
    }
}

extension TaskContentView {
    var taskTitle: some View {
        
        HStack(alignment: .top, spacing: 0, content: {
            Spacer().frame(width: 16, height: 11, alignment: .center)
            VStack{
                Spacer().frame(width: 0, height: 4, alignment: .center)
                CheckBoxView(size: .NORMAL, done: true)
            }
            Spacer().frame(width: 8, height: 1, alignment: .center)
            Text("😂 Сделать суперсложный и супербольшой очет, очень горит.")
                .font(
                    SolFonts.font(
                        size: 24,
                        weight: Font.Weight.medium,
                        color: SolColor.colors().checkBox.doneBackground))
                .foregroundColor(SolColor.colors().checkBox.doneBackground)
                .strikethrough(true, color: SolColor.colors().checkBox.doneBackground)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading)
            
            Spacer().frame(width: 8, height: 1, alignment: .center)
        })
    }
}

extension TaskContentView {
    var actionsTitle:some View {
        VStack{
            Spacer().frame(width: 1, height: 16, alignment: .center)
            
            HStack(alignment: .center){
                Spacer()
                    .frame(width: 12, height: 0, alignment: .center)
                IconComponent(size: 24, icon: "⚙️")
                Spacer()
                    .frame(width: 8, height: 0, alignment: .center)
                Text("Actions")
                    .font(
                        SolFonts.font(
                            size: 24,
                            weight: Font.Weight.medium,
                            color: SolColor.colors().fontColors.normal))
                Spacer()
                Spacer().frame(width: 16, height: 0, alignment: .center)
            }
        }
    }
}

extension TaskContentView {
    var headerSpacer: some View {
        HStack{
            Spacer()
                .frame(width: .infinity, height: (41 + 41 + 16), alignment: .center)
        }
    }
}


struct TaskContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskContentView()
    }
}

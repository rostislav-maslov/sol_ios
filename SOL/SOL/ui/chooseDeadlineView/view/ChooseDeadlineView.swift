//
//  ChooseDeadlineComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.06.2021.
//

import SwiftUI

import SwiftUI
import EventKit
import EventKitUI
import UIKit



struct ChooseDeadlineView: View {
    @Binding var isPresented: Bool
    @Binding var date: Date?
    public var onClear: ( () -> Void )
    public var onSubmit: ( () -> Void )
    
    @State var useCancel = false
    @State var useSubmit = false
    @State var datetimePickerValue: Date = Date()
    @State private var state = ViewState.NORMAL
    
    
    var body: some View {
        Text("").sheet(
            isPresented: $isPresented,
            onDismiss: {
                if useCancel == true {
                    useCancel = false
                    return
                }
                if useSubmit == true {
                    useSubmit = false
                    return
                }
                
                date = datetimePickerValue
                onSubmit()
            },
            content: {
                content
            })                           
    }
    
    var content: some View {
        VStack{
            Spacer()
            
            HStack{
                Spacer().frame(width: 8, height: 0, alignment: .center)
                Text("Deadline")
                    .font(SolFonts.font(
                            size: 32,
                            weight: Font.Weight.black,
                            color: SolColor.colors().fontColors.normal))
                Spacer()
            }
            
            Spacer()
                .frame(width: 0, height: 24, alignment: .center)
            
            HStack{
                Spacer().frame(width: 8, height: 0, alignment: .center)
                DatePicker("", selection: $datetimePickerValue)
                    .labelsHidden()
                    .background(SolColor.colors().addTask.addTaskBackground)
                    .datePickerStyle(GraphicalDatePickerStyle())
                Spacer().frame(width: 8, height: 0, alignment: .center)
            }
            
            Spacer()
                .frame(width: 0, height: 24, alignment: .center)
            
            HStack{
                Spacer().frame(width: 8, height: 0, alignment: .center)
                ButtonComponent(title: "Clear", state: $state) {
                    useCancel = true
                    date = nil
                    onClear()
                }
                Spacer().frame(width: 16, height: 0, alignment: .center)
                ButtonComponent(title: "Submit", state: $state) {
                    useSubmit = true
                    date = datetimePickerValue
                    onSubmit()
                }
                Spacer().frame(width: 8, height: 0, alignment: .center)
            }
            Spacer()
        }
        .preferredColorScheme(.light)
        .background(SolColor
                        .colors()
                        .addTask
                        .addTaskBackground
                        .edgesIgnoringSafeArea(.all))
        .onAppear(perform: {
            if date == nil {
                let currentDate = Calendar.current.date(bySettingHour: 19, minute: 00, second: 0, of: Date())!
                var dateComponent = DateComponents()
                dateComponent.day = 1
                                
                self.datetimePickerValue = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
            }else {
                self.datetimePickerValue = date!
            }
        })
    }
    
}

//struct ChooseDeadlineView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseDeadlineView(dateIn: Date())
//    }
//}

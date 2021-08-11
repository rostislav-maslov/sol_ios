//
//  IconFieldComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 30.05.2021.
//

import SwiftUI

struct IconFieldComponent: View {
    var placeholder: String = "😀"
    var value: Binding<String>
    var state: Binding<ViewState>
    var textFieldShouldBeginEditing: (() -> Void)
    var callbackEmojiTextField: ((_ emojiTextField:UIEmojiTextField) -> Void)
    
    var body: some View {
        ZStack{
            
            if self.value.wrappedValue == "" {
                Image("emoji_deafult_button")
            }else{
                Text(self.value.wrappedValue)
            }
            HStack{
                Spacer().frame(width: 10, height: 0, alignment: .center)
                
                EmojiTextField(text: Binding<String>(get: {
                    return value.wrappedValue
                }, set: { (newValue: String) in
                    print(newValue)
                    print(newValue.count)
                    if newValue.count == 1 {
                        self.value.wrappedValue = newValue
                    }else {
                        let newValue = newValue.replacingOccurrences(of: self.value.wrappedValue, with: "")
                        if newValue.count == 1 {
                            self.value.wrappedValue = newValue
                        }
                    }
                }), textFieldShouldBeginEditing: {
                    self.textFieldShouldBeginEditing()
                }, placeholder: self.placeholder, callbackEmojiTextField: self.callbackEmojiTextField)
                
                .frame(width: 34, height: 44, alignment: .center)
                
            }.opacity(0.1)

        }
        .frame(width: 44, height: 44, alignment: .center)
        .onAppear(perform: {
            
        })
    }
}

struct IconFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        IconFieldComponent(placeholder: "", value: Binding<String>(get: {
            return "d"
        }, set: { (s:String) in
            
        }), state: Binding<ViewState>(get: {
            return ViewState.NORMAL
        }, set: { (vs:ViewState) in
            
        }), textFieldShouldBeginEditing: {
            
        }, callbackEmojiTextField: { (emojiTextField:UIEmojiTextField) in 
            
        })
    }
}

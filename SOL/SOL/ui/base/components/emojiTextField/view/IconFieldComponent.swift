//
//  IconFieldComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 30.05.2021.
//

import SwiftUI
import Combine

struct IconFieldComponent: View {
    @Binding var placeholder: String
    @Binding var emoji: String
    @Binding var stopEditing: Bool
    
    var textFieldShouldBeginEditing: (() -> Void)
    //var callbackEmojiTextField: ((_ emojiTextField:UIEmojiTextField) -> Void)
    
    var body: some View {
        ZStack{
            if self.emoji == "" {
                Image("emoji_deafult_button")
            }else{
                Text(self.emoji)
            }
            HStack{
                Spacer().frame(width: 10, height: 0, alignment: .center)
                
                EmojiTextField(
                    text: $emoji,
                    placeholder: $placeholder,
                    stopEditing: $stopEditing){
                        textFieldShouldBeginEditing()
                    }
                    .frame(width: 34, height: 44, alignment: .center)
                
//                EmojiTextField(text: Binding<String>(get: {
//                    return self.spaceStore.spaces[spaceId]!.icon.data
//                }, set: { (newValue: String) in
//                    print(newValue)
//                    print(newValue.count)
//                    if newValue.count == 1 {
//                        self.spaceStore.spaces[spaceId]!.icon.data = newValue
//                    }else {
//                        let newValue = newValue.replacingOccurrences(of: self.spaceStore.spaces[spaceId]!.icon.data, with: "")
//                        if newValue.count == 1 {
//                            self.spaceStore.spaces[spaceId]!.icon.data = newValue
//                        }
//                    }
//
//                    dddd = UUID()
//                }), textFieldShouldBeginEditing: {
//                    self.textFieldShouldBeginEditing()
//                }, placeholder: self.placeholder,
//                callbackEmojiTextField: self.callbackEmojiTextField)
                
                
                
                
            }.opacity(0.1)

        }
        .frame(width: 44, height: 44, alignment: .center)
        .onAppear(perform: {
            
        })
    }
}

//struct IconFieldComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        IconFieldComponent(placeholder: "", value: Binding<String>(get: {
//            return "d"
//        }, set: { (s:String) in
//            
//        }), state: Binding<ViewState>(get: {
//            return ViewState.NORMAL
//        }, set: { (vs:ViewState) in
//            
//        }), textFieldShouldBeginEditing: {
//            
//        }, callbackEmojiTextField: { (emojiTextField:UIEmojiTextField) in 
//            
//        })
//    }
//}

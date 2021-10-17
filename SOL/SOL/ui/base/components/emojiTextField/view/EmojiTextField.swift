//
//  EmojiTextField.swift
//  SOL
//
//  Created by Rostislav Maslov on 07.08.2021.
//

import Foundation
import SwiftUI

public struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var placeholder: String
    @Binding var stopEditing: Bool
    var textFieldDidBeginEditing: (() -> Void)    
    
    public func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    public func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        
        if stopEditing == true {
            stopEditing = false
            uiView.endEditing(false)
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.textFieldDidBeginEditing()
        }
        
        public func textFieldDidChangeSelection(_ textField: UITextField) {
            var newValue:String = textField.text ?? ""
            print(newValue)
            print(newValue.count)

            if newValue.count == 1 {
                parent.text = newValue
            }else {
                newValue = newValue.replacingOccurrences(of: parent.text, with: "")
                if newValue.count == 1 {
                    parent.text = newValue
                }
            }
        }
    }
}

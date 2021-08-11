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
    var textFieldShouldBeginEditing: (() -> Void)
    var placeholder: String = ""
    var callbackEmojiTextField: ((_ emojiTextField:UIEmojiTextField) -> Void)
    
    public func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        callbackEmojiTextField(emojiTextField)
        return emojiTextField
    }
    
    public func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            parent.textFieldShouldBeginEditing()
            return true
        }
        
        public func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}

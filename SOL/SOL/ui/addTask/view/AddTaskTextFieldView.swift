//
//  AddTaskTextFieldView.swift
//  SOL
//
//  Created by Rostislav Maslov on 07.08.2021.
//

import Foundation
import SwiftUI

public struct AddTaskTextFieldView: UIViewRepresentable {
    @Binding var text: String
    var textFieldShouldBeginEditing: (() -> Void)
    var placeholder: String = ""
    var callbackTitleTextField: ((_ emojiTextField: UITextField) -> Void)
    
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.text = text
        textField.delegate = context.coordinator
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        callbackTitleTextField(textField)
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        var parent: AddTaskTextFieldView
        
        init(parent: AddTaskTextFieldView) {
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

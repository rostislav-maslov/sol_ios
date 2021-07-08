//
//  IconFieldComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 30.05.2021.
//

import SwiftUI


class UIEmojiTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default // do not remove this
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}

struct IconFieldComponent: View {
    var placeholder: String = "😀"
    var value: Binding<String>
    var state: Binding<ViewState>
    //@State var emoji: String = ""
    
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
                }), placeholder: self.placeholder)
                
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
            
        }))
    }
}

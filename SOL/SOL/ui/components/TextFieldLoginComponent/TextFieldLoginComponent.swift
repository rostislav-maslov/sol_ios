//
//  TextFieldLoginComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 27.05.2021.
//

import SwiftUI

struct TextFieldLoginComponent: View {
    var placeholder: String
    var value: Binding<String>
    var secured: Bool
    var keyboardType: UIKeyboardType?
    var state: Binding<ViewState>
    var autocapitalization:UITextAutocapitalizationType = .none
    
    var body: some View {
        ZStack{
            if (secured == false) {
                TextField(placeholder, text: self.value)
                    .autocapitalization(autocapitalization)
                    .keyboardType(self.keyboardType != nil ? self.keyboardType! : .default)
                    .font(SolFonts.font(size: 16, weight: Font.Weight.medium, color: SolColor.colors().fontColors.normal))
                    .padding()
            } else {
                SecureField(placeholder, text: self.value)
                    .font(SolFonts.font(size: 16, weight: Font.Weight.medium, color: SolColor.colors().fontColors.normal))
                    .padding()
            }
        }
        .frame(width: .infinity, height: 44, alignment: .center)
        .background(SolColor.colors().textField.login)
        .cornerRadius(8.0)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(self.state.wrappedValue == .ERROR ? Color.red : Color.clear, lineWidth: 1)
        )
        
        
    }
}

struct TextFieldLoginComponent_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldLoginComponent(placeholder: "Placeholder", value: Binding.init(get: {
            return ""
        }, set: { _ in
            
        }), secured: true, state: Binding.init(get: {
            return .NORMAL
        }, set: { _ in
            
        }))
    }
}

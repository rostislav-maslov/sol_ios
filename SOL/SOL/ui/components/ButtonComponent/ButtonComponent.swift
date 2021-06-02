//
//  ButtonComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 27.05.2021.
//

import SwiftUI


struct ButtonComponent: View {
    var title: String
    var state: Binding<ViewState>
    var action:  () -> Void
    
    func didTouch() -> Void {
        if state.wrappedValue != .LOADING {
            action()
        }
    }
    
    var body: some View {
        Button(action: didTouch) {
            if state.wrappedValue == .LOADING {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .padding()
            } else {
                Text(title)
                    .font(SolFonts.font(size: 16, weight: .medium, color: SolColor.colors().button.font))
                    .foregroundColor(SolColor.colors().button.font)
                    .padding(.vertical, 10.0)
                    .frame(maxWidth: .infinity)
            }
            
        }
        .background(
            state.wrappedValue == .LOADING ?
                SolColor.colors().button.backgroundLoading :
                SolColor.colors().button.background
            
        )
        .cornerRadius(8)
    }
}

struct ButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponent(title: "Button", state: Binding<ViewState>(get: {
            return .NORMAL
        }, set: { _ in
            
        })) {
            
        }
    }
}

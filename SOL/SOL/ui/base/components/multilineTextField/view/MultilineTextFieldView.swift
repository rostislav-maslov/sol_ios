//
//  MultilineTextView.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI
import Combine

struct MultilineTextFieldView: UIViewRepresentable {
    @Binding var text: String
    @ObservedObject var model: MultilineTextFieldModel
    
    var textColor: UIColor
    var textSize: CGFloat    
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.clear
        view.textColor = textColor
        view.tintColor = textColor
        let font:UIFont = UIFont.systemFont(ofSize: textSize, weight: UIFont.Weight.medium)
        view.font = font
        view.delegate = self.model
        view.returnKeyType = UIReturnKeyType.done
        
        let sizeThatFitsTextView = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat(MAXFLOAT)))
        
        if model.firstSizeTitle == 0 {
            model.firstSizeTitle = sizeThatFitsTextView.height
            model.titleSize = sizeThatFitsTextView.height
        }
        //self.frame(height: sizeThatFitsTextView.height)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        model.updateTitleSize(uiView)
        //self.frame(height: heightOfText)

    }
    
  
}

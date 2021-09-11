//
//  MultilineTextFieldModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI
import Combine

public protocol MultilineTextFieldProtocol {
    func textDidChange(text: String)
    func textEditFinish(text: String)
}

public class MultilineTextFieldModel: NSObject, ObservableObject, UITextViewDelegate{
    @Published var detectFirstSizeTitle:Bool = false
    @Published var firstSizeTitle:CGFloat = 0
    @Published var titleSize:CGFloat = (24 + 8) * 1
    
    public var delegate: MultilineTextFieldProtocol?
    
    public func textViewDidChange(_ textView: UITextView) {
        let sizeThatFitsTextView = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat(MAXFLOAT)))
        let heightOfText = sizeThatFitsTextView.height + 10
        
            DispatchQueue.main.async {
                self.titleSize = heightOfText
                self.firstSizeTitle = sizeThatFitsTextView.height
                self.detectFirstSizeTitle = true
                print(self.titleSize)
            }
        delegate?.textDidChange(text: textView.text)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            delegate?.textEditFinish(text: textView.text)
            return false
        }
        return true
    }
    
    func updateTitleSize(_ uiView: UITextView) {
        let sizeThatFitsTextView = uiView.sizeThatFits(CGSize(width: uiView.frame.size.width, height: CGFloat(MAXFLOAT)))
        let heightOfText = sizeThatFitsTextView.height + 10
        
        if self.detectFirstSizeTitle == false || heightOfText != self.titleSize {
            self.titleSize = heightOfText
            self.firstSizeTitle = sizeThatFitsTextView.height
            self.detectFirstSizeTitle = true
            self.textViewDidChange(uiView)
        }
        
    }
}

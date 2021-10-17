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
    //var text: String
    
    var textColor: Color
    var textSize: CGFloat
    var textDidChange : ((_ text: String) -> Void)
    var textEditFinish :   ((_ text: String) -> Void)
    var titleSizeDidChange :   ((_ titleSize: CGFloat) -> Void)
    var multilineTextFieldView :   ((_ view: UITextView) -> Void)
    
    @StateObject var model: MultilineTextFieldModel = MultilineTextFieldModel()
    @State var text:String = ""
    init(  text: String,
           textColor: Color,
           textSize: CGFloat,           
           textDidChange : @escaping ((_ text: String) -> Void),
           textEditFinish :  @escaping ((_ text: String) -> Void),
           titleSizeDidChange :  @escaping ((_ titleSize: CGFloat) -> Void),
           multilineTextFieldView :  @escaping ((_ view: UITextView) -> Void)){
        
        self.text = text
        self.textColor = textColor
        self.textSize = textSize
        
        self.textDidChange = textDidChange
        self.textEditFinish = textEditFinish
        self.titleSizeDidChange = titleSizeDidChange
        self.multilineTextFieldView = multilineTextFieldView
        
    }
    
    func makeUIView(context: Context) -> UITextView {
        model.textDidChange = textDidChange
        model.textEditFinish = textEditFinish
        model.titleSizeDidChange = titleSizeDidChange
        model.multilineTextFieldView = multilineTextFieldView

        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor(textColor)
        view.tintColor = UIColor(textColor)
        
        //let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        //attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        //attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: SolColor.colors().fontColors.second, range: NSMakeRange(0, attributeString.length))
            
        
        //view.attributedText = attributeString
        let font:UIFont = UIFont.systemFont(ofSize: textSize, weight: UIFont.Weight.medium)
        view.font = font
        
        view.delegate = self.model
        view.returnKeyType = UIReturnKeyType.done
        view.text = self.text
        
        let sizeThatFitsTextView = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat(MAXFLOAT)))
        
        if model.firstSizeTitle == 0 {
            model.firstSizeTitle = sizeThatFitsTextView.height
            model.titleSize = sizeThatFitsTextView.height
            //model.titleSizeDidChange(model.titleSize)
            //model.updateTitleSize(view)
        }
        //self.frame(height: sizeThatFitsTextView.height)
        
        model.multilineTextFieldView?(view)
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        //uiView.text = text
        uiView.delegate = model
        //uiView.text = text
        model.updateTitleSize(uiView)        
        //self.frame(height: heightOfText)
    }
    
    
}

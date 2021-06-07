//
//  TaskFieldButtonComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.06.2021.
//

import SwiftUI

struct TaskFieldButtonComponent: View {
    var imageName:String
    var title:String
    var choosed:Bool
    var didTouch: () -> Void
    
    var body: some View {
        Button(action: didTouch) {
            ZStack{
                HStack{
                    Image(imageName)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(CGColor(
                            red:68/255, green: 68/255, blue: 68/255, alpha: 1
                        )))
                        .scaledToFit()
                        .frame(width: 10, height: 10, alignment: .center)
                    
                    Spacer().frame(width: 4, height: 0, alignment: .center)
                    Text(title)
                        .foregroundColor(SolColor.colors().fontColors.normal)
                        .font(
                            SolFonts.font(
                                size: 10,
                                weight: Font.Weight.medium,
                                color: SolColor.colors().fontColors.normal))
                        
                }
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(SolColor.colors().addTask.placeholderBackground, lineWidth: 1)
                )
                
            }
            
        }
    }
}

struct TaskFieldButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        TaskFieldButtonComponent(imageName: "deadline", title: "Deadline", choosed: false) {
            
        }
    }
}

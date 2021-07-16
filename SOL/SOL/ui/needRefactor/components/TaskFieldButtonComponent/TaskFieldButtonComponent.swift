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
                        .foregroundColor(
                            choosed ?
                                SolColor.colors().addTask.taskButtonActiveColor :
                                SolColor.colors().addTask.taskButtonDefaultColor
                        )
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                }
                .padding(0)
                
                
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

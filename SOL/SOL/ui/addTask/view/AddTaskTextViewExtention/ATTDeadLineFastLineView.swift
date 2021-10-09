//
//  ATTDeadLineFastLineView.swift
//  SOL
//
//  Created by Rostislav Maslov on 25.09.2021.
//

import SwiftUI

extension AddTaskTextView{
    var deadlineFastLine: some View {
        HStack{
            Spacer().frame(width: 16, height: 1, alignment: .center)
            
            Button(action: {}, label: {
                Text("Today")
            })
            Spacer().frame(width: 8, height: 1, alignment: .center)
            Button(action: {}, label: {
                Text("Tomorrow")
            })
            Spacer().frame(width: 8, height: 1, alignment: .center)
            Button(action: {}, label: {
                Text("This week")
            })
            Spacer().frame(width: 8, height: 1, alignment: .center)
            Button(action: {}, label: {
                Text("Choose")
            })
            
            Spacer()
        }
        .hidden()
        .frame(width: nil)
    }
}

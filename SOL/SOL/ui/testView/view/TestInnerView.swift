//
//  TestInnerView.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.09.2021.
//

import SwiftUI

struct TestInnerView: View {
    @EnvironmentObject var store: EnvStore
    @State var index:Int = 0
    @ObservedObject var model: EnvModel = EnvModel()
    
    var body: some View {
        
        Button(action: {
            self.index = Int.random(in: 0..<store.tasks.count)
        }, label: {
            Text(store.tasks.count > 0 ? "Bu - \(store.tasks[index]!.title)" : "need init")
        })
        
        .onAppear(perform: {
            model.store = self.store
        })
    }
}

struct TestInnerView_Previews: PreviewProvider {
    static var previews: some View {
        TestInnerView()
    }
}

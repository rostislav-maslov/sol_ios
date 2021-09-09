//
//  TestView.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.09.2021.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var store: EnvStore
    @ObservedObject var model: EnvModel = EnvModel()
    
    var body: some View {
        VStack{
            Text("Count - \(store.tasks.count)")
            Button(action: {
                model.generate()
            }, label: {
                Text("generate")
            })
            TestInnerView()
            TestInnerView()
            TestInnerView()
            TestInnerView()
            TestInnerView()
            TestInnerView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
        .onAppear(perform: {
            model.store = self.store
        })
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

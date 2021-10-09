//
//  ListExample.swift
//  SOL
//
//  Created by Rostislav Maslov on 31.08.2021.
//

import SwiftUI

import Combine

struct Item: Identifiable {
    let id = UUID()
    let title: String
}

struct ListExample: View {

    @State private var items: [Item] = (0..<15).map { Item(title: "Item #\($0)") }
    @State private var isEditable = false
    
    public var body: some View {
        ZStack {
            List{
                Spacer().frame(width: 1, height: 64, alignment: .center)
                ForEach(items) { item in
                                Text(item.title)
                            }
                
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
                .onLongPressGesture {
                                withAnimation {
                                    self.isEditable = true
                                }
                            }
            }
            .frame(width: .infinity, height: .infinity, alignment: .center)
            SolNavigationView()
        }
        .environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
    }
    
    // 2.
       private func onDelete(offsets: IndexSet) {
           items.remove(atOffsets: offsets)
       }

       // 3.
       private func onMove(source: IndexSet, destination: Int) {
           items.move(fromOffsets: source, toOffset: destination)
        withAnimation {
                    isEditable = false
                }
       }
}

struct ListExample_Previews: PreviewProvider {
    static var previews: some View {
        ListExample()
    }
}

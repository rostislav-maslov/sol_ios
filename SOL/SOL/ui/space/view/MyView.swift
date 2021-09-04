//
//  MyView.swift
//  SOL
//
//  Created by Rostislav Maslov on 31.08.2021.
//

import SwiftUI
import Combine

protocol middleManProtocol {
    func swapPerson(myName:String, nameMovingElement:String)->Bool
}

class MiddleMan:ObservableObject{
    @Published var people = [PersonRow]()
}

struct Person: Identifiable, Hashable {
    var id = UUID()
    var name: String
}

struct PersonRow: View, Identifiable {
    var id = UUID()
    var person: Person

    @State var targeted: Bool = true
    var delegate: middleManProtocol
    @State var positionOnScroll:CGPoint = .zero
    var body: some View {
        HStack {
                Image(systemName: "person.circle")
                Text(person.name)
                Text(person.id.description)
            }
            .onDrop(of: ["public.utf8-plain-text"], isTargeted: self.$targeted,
                    perform: { (provider) -> Bool in
                        guard let personSwaping = provider.first, let name = personSwaping.suggestedName
                            else { return false}
                        return self.delegate.swapPerson(myName: self.person.id.uuidString,
                                                        nameMovingElement: name)

            })
            .onDrag {
                let item = NSItemProvider(object: NSString(string: self.person.name))
                item.suggestedName = self.person.id.uuidString
                return item
            }
    }
    

    
}

struct MyView : View, middleManProtocol{
    func swapPerson(myName:String, nameMovingElement:String)->Bool{
        print("swap running")

        //Get index of person (me) and get the index of the one moving
        guard let indexOfElementMoving = self.delegate.people.firstIndex(where: {$0.person.id.uuidString == nameMovingElement}) else {
            return false
        }
        print("got index of moving provider", indexOfElementMoving)
        guard let myIndex = self.delegate.people.firstIndex(where: {$0.person.id.uuidString == myName}) else {return false}
        print("got my index", myIndex)
        //Swap
        //self.delegate.people.swapAt(myIndex, indexOfElementMoving)
        //self.delegate.people.move(fromOffsets: indexOfElementMoving!, toOffset: myIndex!)
       // self.delegate.people.move(fromOffsets: <#T##IndexSet#>, toOffset: myIndex)
        return true
    }
    

    @ObservedObject var delegate: MiddleMan = MiddleMan()
    @State var targeted: Bool = true

    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            VStack {
                ForEach(delegate.people) { person in
                    person
                        .frame(width: .infinity, height:100)

                }
                
            }.frame(width: .infinity, height: .infinity, alignment: .center)
            
        }.onAppear {
            
            //Do your call to server or model  or whatever
            //I don't like the delegate setter like this, pretty sure i can create a better approach, just doing it like this for now.
            self.delegate.people = [
                PersonRow(person: Person(name: "1"), delegate: self),
                PersonRow(person: Person(name: "2"), delegate: self),
            PersonRow(person: Person(name: "3"), delegate: self),
            PersonRow(person: Person(name: "4"), delegate: self),
            PersonRow(person: Person(name: "5"), delegate: self),
                PersonRow(person: Person(name: "6"), delegate: self),
                PersonRow(person: Person(name: "7"), delegate: self),
                PersonRow(person: Person(name: "8"), delegate: self),
                PersonRow(person: Person(name: "9"), delegate: self),
                PersonRow(person: Person(name: "10"), delegate: self),
            ]
            
        }
        
    }

    
    
}

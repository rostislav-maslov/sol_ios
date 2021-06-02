//
//  ContentView.swift
//  SOL
//
//  Created by Rostislav Maslov on 20.04.2021.
//

import SwiftUI

import AVFoundation

struct DetailView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userBy: UserBy
    
    var text: String
    var body: some View {
        VStack(spacing: 30) {
            Text("\(self.text) - \(self.userBy.caps)")
                
                .navigationBarItems(leading:
                                        Button("Back") {
                                            self.presentation.wrappedValue.dismiss()
                                        },
                                    trailing: HStack{
                                        Button(" - ") {
                                            self.userBy.caps -= 1
                                        }
                                        
                                        Button(" + ") {
                                            self.userBy.caps += 1
                                        }
                                    }
                )
            
            
        }
        
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            self.userBy.caps = 0
        }
        
    }
}

class UserBy: ObservableObject {
    @Published public var caps = 0
}

struct RefreshControl: View {
    var coordinateSpace: CoordinateSpace
    var onRefresh: ()->Void
    @State var refresh: Bool = false
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: coordinateSpace).midY > 50) {
                Spacer()
                    .onAppear {
                        if refresh == false {
                            onRefresh() ///call refresh once if pulled more than 50px
                        }
                        refresh = true
                    }
            } else if (geo.frame(in: coordinateSpace).maxY < 1) {
                Spacer()
                    .onAppear {
                        refresh = false
                        ///reset  refresh if view shrink back
                    }
            }
            ZStack(alignment: .center) {
                if refresh { ///show loading if refresh called
                    ProgressView()
                } else { ///mimic static progress bar with filled bar to the drag percentage
                    ForEach(0..<8) { tick in
                          VStack {
                              Rectangle()
                                .fill(Color(UIColor.tertiaryLabel))
                                .opacity((Int((geo.frame(in: coordinateSpace).midY)/7) < tick) ? 0 : 1)
                                  .frame(width: 3, height: 7)
                                .cornerRadius(3)
                              Spacer()
                      }.rotationEffect(Angle.degrees(Double(tick)/(8) * 360))
                   }.frame(width: 20, height: 20, alignment: .center)
                }
            }.frame(width: geo.size.width)
        }.padding(.top, -50)
    }
}

struct ContentView: View {
    @ObservedObject var userBy = UserBy()
    @State private var isShowing = false
    let coffe = "coffe"
    let tea = "tea"
    
    
   
    
    var body: some View {
        NavigationView{
            
            ScrollView {
                RefreshControl(coordinateSpace: .named("RefreshControl")) {
                    self.userBy.caps += 2
                           }
                VStack{
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                }
                VStack{
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                    Text("Ur choose - \(userBy.caps)")
                }
                    
                    NavigationLink(
                        destination: DetailView(text: coffe),
                        label: {
                            Text(coffe)
                        })

                        .navigationBarTitle("Menu", displayMode: NavigationBarItem.TitleDisplayMode.large)

                    NavigationLink(
                        destination: DetailView(text: tea),
                        label: {
                            Text(tea)
                        })

                        .navigationBarTitle("Menu", displayMode: NavigationBarItem.TitleDisplayMode.large)
                    
                
            }.coordinateSpace(name: "RefreshControl")
    }
            
        
        
        .environmentObject(userBy)
        
        
    }
    
    
}


struct ListSeparatorStyle: ViewModifier {
    
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = self.style
            }
    }
}

extension View {
    
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

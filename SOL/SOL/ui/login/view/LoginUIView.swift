//
//  LoginUIView.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.04.2021.
//

import SwiftUI

struct LoginUIView: View {
    @State private var enter:String = ""
    @State private var navigationSelection: Int? = nil
    
    
    func onClickEmail() -> Void {
        self.navigationSelection = 1        
    }
    
    var body: some View {
       // NavigationView {
            ZStack{
                SolColor.colors().screen.background.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Spacer()
                    VStack(alignment: .leading){
                        Text("Hey!")
                            .font(.system(size: 32))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 68.0/255, green: 68.0/255, blue: 68.0/255, opacity: 1.0))
                            .multilineTextAlignment(.leading)
                        Text("Unload your head")
                            .font(.system(size: 32))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 68.0/255, green: 68.0/255, blue: 68.0/255, opacity: 1.0))
                            .multilineTextAlignment(.leading)
                        Text("and do it.")
                            .font(.system(size: 32))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 68.0/255, green: 68.0/255, blue: 68.0/255, opacity: 1.0))
                            .multilineTextAlignment(.leading)
                        Text(" ")
                            .font(.system(size: 32))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 68.0/255, green: 68.0/255, blue: 68.0/255, opacity: 1.0))
                            .multilineTextAlignment(.leading)
                        Text("Let's log in first")
                            .font(.system(size: 32))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 68.0/255, green: 68.0/255, blue: 68.0/255, opacity: 1.0))
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    //TextField("Enter your name", text: $enter)
                    // --------
                    VStack{
                        Button(action: {
                            //self.authState.login()
                        }) {
                            Text("Apple ID")
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0))
                                .padding(.vertical, 10.0)
                                .frame(maxWidth: .infinity)
                            
                        }
                        .background(Color(red: 18/255, green: 18/255, blue: 18/255, opacity: 1.0))
                        .cornerRadius(8)
                        Spacer()
                            .frame(height: 16.0)
                        // --------
                        Button(action: {
                            print("Button action")
                        }) {
                            Text("Facebook")
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0))
                                .padding(.vertical, 10.0)
                                .frame(maxWidth: .infinity)
                            
                        }
                        .background(Color(red: 66/255, green: 103/255, blue: 178/255, opacity: 1.0))
                        .cornerRadius(8)
                        Spacer()
                            .frame(height: 16.0)
                        ///---------
                        Button(action: {
                            print("Button action")
                        }) {
                            Text("Google")
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0))
                                .padding(.vertical, 10.0)
                                .frame(maxWidth: .infinity)
                            
                        }
                        .background(Color(red: 234/255, green: 67/255, blue: 53/255, opacity: 1.0))
                        .cornerRadius(8)
                        
                        Spacer()
                            .frame(height: 16.0)
                        //-------------
                        
                        NavigationLink(destination: LoginByEmailView(), tag: 1, selection: $navigationSelection) { EmptyView() }
                        Button(action: {
                            self.onClickEmail()
                        }) {
                            Text("Email")
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0))
                                .padding(.vertical, 10.0)
                                .frame(maxWidth: .infinity)
                            
                        }
                        
                        .background(Color(red: 136/255, green: 136/255, blue: 136/255, opacity: 1.0))
                        .cornerRadius(8)
                        
                        Spacer()
                            .frame(height: 16.0)
                    }
                    Spacer()
                }.padding()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                self.navigationSelection = 0
            })
            
    }
}

struct LoginUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUIView()
            .preferredColorScheme(.light)
    }
}

//
//  NavigationView.swift
//  SOL
//
//  Created by Rostislav Maslov on 17.07.2021.
//

import SwiftUI

struct SolNavigationView: View {
    var body: some View {
        VStack {
            VStack{
                Spacer().frame(width: 16, height: 16, alignment: .center)
                HStack{
                    Spacer().frame(width: 16, height: 1, alignment: .center)
                    BackButton()
                    Spacer().frame(width: 0, height: 1, alignment: .center)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                        Button("StringProtocol") {
                            
                        }
                        Button("StringProtocol") {
                            
                        }
                        Button("StringProtocol") {
                            
                        }
                        Button("StringProtocol") {
                            
                        }
                        Button("StringProtocol") {
                            
                        }
                            
                        }
                    }.frame(width: .infinity, height: 44, alignment: .center)
                    Spacer().frame(width: 8, height: 1, alignment: .center)
                    SettingButton()
                    Spacer().frame(width: 16, height: 1, alignment: .center)
                }
                Spacer().frame(width: 16, height: 16, alignment: .center)
            }
            Spacer()
        }
    }
}

struct SolNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SolNavigationView()
    }
}

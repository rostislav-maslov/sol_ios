//
//  CompandComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

struct CompandComponent: View {
    var width:CGFloat = 156
    var body: some View {
        ZStack{
            Rectangle()
                .fill( Color(CGColor(red: 246/255,green: 246/255,blue: 246/255, alpha: 1)) )
                .frame(width: width, height: 64, alignment: .center)
                .border(Color.white, width: 0)
                .cornerRadius(8.0)
            
            HStack{
                Spacer()
                    .frame(width: 10, height: 4, alignment: .center)
                VStack{
                    Text("📥")
                        .font(.system(size: 16))
                    Spacer()
                        .frame(width: 20, height: 21, alignment: .center)
                }
                Spacer()
                    .frame(width: 7, height: 2, alignment: .center)
                VStack{
                    HStack{
                        Text("All task")
                            .font(.system(size: 16))
                        Spacer()
                    }
                    Spacer()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 4, alignment: .center)
                    HStack{
                        Text("120 pt")
                            .font(.system(size: 12))
                            .foregroundColor(Color( CGColor(red: 175/255,green:  175/255,blue: 175/255,  alpha: 1)))
                        Text("12.12.2020")
                            .font(.system(size: 12))
                            .foregroundColor(Color( CGColor(red: 175/255,green:  175/255,blue: 175/255,  alpha: 1)))
                        Spacer()
                    }
                }
            }
            
           
            
            
        }
        .frame(width: width, height: 64, alignment: .center)
        
    }
}

struct CompandComponent_Previews: PreviewProvider {
    static var previews: some View {
        CompandComponent()
            .preferredColorScheme(.light)
    }
}

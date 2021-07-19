//
//  CompandComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

struct ActionButtonView: View {
    var width:CGFloat = 156
    
    var title: String
    var titleColor: Color = SolColor.colors().fontColors.normal
    
    var icon: String
    var iconColor: Color = SolColor.colors().actionButton.taskDone
    var iconWidth: CGFloat = 14
    var iconHeight: CGFloat = 14
    var iconVerticalSpace: CGFloat = 14
    var subTitle: String
    var didTouch: (() -> Void)?
    
    init(
        title: String,
        icon: String,
        subTitle: String
    ) {
        self.title = title
        self.icon = icon
        self.subTitle = subTitle
    }
    
    init(  title: String,
           titleColor: Color ,           
           icon: String,
           iconColor: Color,
           iconWidth: CGFloat,
           iconHeight: CGFloat,
           iconVerticalSpace: CGFloat,
           subTitle: String) {
        self.title = title
        self.titleColor = titleColor
        self.icon = icon
        self.iconColor = iconColor
        self.iconWidth = iconWidth
        self.iconHeight = iconHeight
        self.iconVerticalSpace = iconVerticalSpace
        self.subTitle = subTitle
    }
    
    init(  title: String,
           titleColor: Color ,
           icon: String,
           iconColor: Color,
           iconWidth: CGFloat,
           iconHeight: CGFloat,
           iconVerticalSpace: CGFloat,
           subTitle: String,
           didTouch: @escaping () -> Void) {
        self.title = title
        self.titleColor = titleColor
        self.icon = icon
        self.iconColor = iconColor
        self.iconWidth = iconWidth
        self.iconHeight = iconHeight
        self.iconVerticalSpace = iconVerticalSpace
        self.subTitle = subTitle
        self.didTouch = didTouch
    }
    
    var body: some View {
        
        Button(action: {
            self.didTouch?()
        }, label: {
            ZStack{
                Rectangle()
                    .fill(Color(UIColor(SolColor.colors().actionButton.background)))
                    .frame(width: width, height: 64, alignment: .center)
                    .border(Color.white, width: 0)
                    .cornerRadius(8.0)
                HStack{
                    Spacer()
                        .frame(width: 10, height: 4, alignment: .center)
                    VStack{
                        Spacer()
                            .frame(width: 1, height: iconVerticalSpace, alignment: .center)
                        Image(icon)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: iconWidth, height: iconHeight, alignment: .center)
                            .foregroundColor(
                                iconColor
                            )
                        Spacer()
                            .frame(width: 20, height: 21, alignment: .center)
                    }
                    Spacer()
                        .frame(width: 7, height: 2, alignment: .center)
                    VStack{
                        HStack{
                            Text(title)
                                .font(
                                    SolFonts.font(
                                        size: 16,
                                        weight: Font.Weight.bold,
                                        color: titleColor))
                                .foregroundColor(titleColor)
                            Spacer()
                        }
                        Spacer()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 4, alignment: .center)
                        HStack{
                            Text(subTitle)
                                .font(
                                    SolFonts.font(
                                        size: 12,
                                        weight: Font.Weight.medium,
                                        color: SolColor.colors().fontColors.second))
                                .foregroundColor(SolColor.colors().fontColors.second)
                            Spacer()
                        }
                    }
                }
            }.frame(width: width, height: 64, alignment: .center)
        })
    }
}

struct CompandComponent_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonView(
            title: "Done",
            titleColor: SolColor.colors().actionButton.taskDone,
            icon: "ic_check_done",
            iconColor: SolColor.colors().actionButton.taskDone,
            iconWidth: 14,
            iconHeight: 14,
            iconVerticalSpace: 4,
            subTitle: "Go back to work"
        )
        .preferredColorScheme(.light)
    }
}

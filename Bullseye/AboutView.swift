//
//  AboutView.swift
//  Bullseye
//
//  Created by Dip Dhanesha on 10/4/19.
//  Copyright © 2019 Dip Dhanesha. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let stackBackGroundColor = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct AboutHeaderStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.top, 20)
                .padding(.bottom, 20)
                .padding(.leading, 60)
                .padding(.trailing, 60)
        }
    }
    
    struct AboutContentStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(AboutHeaderStyle())
                Text("This is Bullseye. The game where you can win points and earn fame by dragging a slider.").modifier(AboutContentStyle())
                Text("Your goal is to place the slider as close as possible to target value. The closer you are, the more points you score.").modifier(AboutContentStyle()).lineLimit(Int.max)
                Text("Enjoy!").modifier(AboutContentStyle())
            }
            .navigationBarTitle("About Bullseye")
            .background(stackBackGroundColor)
        }.background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

//
//  ContentView.swift
//  Bullseye
//
//  Created by Dip Dhanesha on 10/1/19.
//  Copyright © 2019 Dip Dhanesha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isAlertVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    let midNightBlue = Color(red: 0.0 / 255, green: 51.0 / 255, blue: 102.0 / 255)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .modifier(Shadow())
            .font(Font.custom("ArialRoundedMTBold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.yellow)
            .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Your target value is:").modifier(LabelStyle())
                Text("\(targetValue)").modifier(ValueStyle())
            }
            Spacer()
            HStack{
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Button(action: {
                self.isAlertVisible = true
            }){
                Text("Hit Me!").modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $isAlertVisible){() -> Alert in
                let roundedValue = Int(sliderValue.rounded())
                return Alert(
                    title: Text("\(alertTitle())"),
                    message: Text(
                        "Slider value is: \(roundedValue).\n" +
                        "You scored: \(pointsForCurrentRound())"
                    ),
                    dismissButton: .default(Text("Dismiss")) {
                        self.score += self.pointsForCurrentRound()
                        self.targetValue = Int.random(in: 1...100)
                        self.round += 1
                    })
            }
            .background(Image("Button")).modifier(Shadow())
            Spacer()
            HStack {
                Button(action: {action: do {self.startNewGame()}}){
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midNightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    
    
    func pointsForCurrentRound() -> Int {
        let maxScore = 100
        let difference = abs(targetValue - Int(sliderValue))
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        let awarededPoints = maxScore - difference + bonus
        return awarededPoints
    }
    
    func alertTitle() -> String {
        let difference = abs(targetValue - Int(sliderValue))
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 1
        targetValue = Int.random(in: 1...100)
        sliderValue = 50.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

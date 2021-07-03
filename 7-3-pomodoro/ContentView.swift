//
//  ContentView.swift
//  7-3-pomodoro
//
//  Created by Jeremy Tow on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    
    var initialCountdown: Double = 10 * 60 // 10 minutes
    
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    @State var seconds: Int = 0;
    @State var status: String = "Start"
    
    var circleDiameter: CGFloat = UIScreen.main.bounds.width * 0.9
    
    var rectHeight: CGFloat = 15
    var rectWidthOffset: CGFloat = 75
    var rectWidthMult: CGFloat = 8
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<8) { i in
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width - rectWidthOffset) / rectWidthMult, height: rectHeight)
                }
            }
            
            ZStack {
                Circle()
                    .fill(Color.primary)
                    .opacity(0.1)
                    .frame(width: circleDiameter, height: circleDiameter, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                ForEach(0..<60) { i in
                    Rectangle()
                        .fill(Color.primary)
                        .opacity(0.7)
                        .offset(x: 0, y: -circleDiameter / 2.3)
                        .rotationEffect(Angle(degrees: Double(i * 6)))
                        .frame(width: 2, height: (i % 5 == 0) ? 20 : 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Rectangle()
                    .fill(Color.primary)
                    .offset(x: 0, y: -circleDiameter / 4)
                    .rotationEffect(Angle(degrees: Double(seconds * 6)))
                    .frame(width: 3, height: circleDiameter / 2)
            }
            .onReceive(receiver, perform: { _ in
                if status == "Stop" {
                    withAnimation(Animation.linear(duration: 0.01)) {
                        seconds += 1;
                    }
                }
            })
            Text(GetFormattedTime(iseconds: initialCountdown))
            Button(status) {
                if (status == "Start") {
                    status = "Stop"
                } else {
                    status = "Start"
                }
            }
        }
    }
    func GetFormattedTime(iseconds: Double) -> String{
        let minutes = Int(floor(iseconds/60))
        let seconds = Int(Int(iseconds) % 60)
        
        return String(minutes) + ":" + ((seconds < 10) ? "0" : "") + String(seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

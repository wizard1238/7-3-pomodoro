//
//  ContentView.swift
//  7-3-pomodoro
//
//  Created by Jeremy Tow on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    
    var initialCountdown: Double = 2 * 60 // 10 minutes
    
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    @State var texts: String = "hello"
    @State var seconds: Int = 0
    @State var status: String = "Start"
    @State var countdown: Double = 0
    @State var section: Int = 1
    @State var phase: String = "Pomodoro Timer"
    @State var colors: [Color] = [Color](repeating: .primary, count: 8)
    
    var circleDiameter: CGFloat = UIScreen.main.bounds.width * 0.9
    
    var rectHeight: CGFloat = 15
    var rectWidthOffset: CGFloat = 75
    var rectWidthMult: CGFloat = 8
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<8) { i in
                    Rectangle()
                        .fill(colors[i])
                        .frame(width: (UIScreen.main.bounds.width - rectWidthOffset) / rectWidthMult, height: rectHeight)
                }
            }
            Text(phase)
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.primary)
                    .opacity(0.1)
                    .frame(width: circleDiameter, height: circleDiameter)
                ForEach(0..<60) { i in
                    Rectangle()
                        .opacity(0.7)
                        .frame(width: 2, height: (i % 5 == 0) ? 20 : 10)
                        .offset(x: 0, y: -circleDiameter / 2.3)
                        .rotationEffect(Angle(degrees: Double(i * 6)))
                }
                Rectangle()
                    .frame(width: 3, height: circleDiameter / 2)
                    .offset(x: 0, y: -circleDiameter / 4)
                    .rotationEffect(Angle(degrees: Double(seconds*6)))
            }
            .onAppear() {
                countdown = Double(getTimeSegment(section: section).rawValue) * 60
            }
            .onReceive(receiver, perform: { _ in
                if (countdown > 0 && status == "Stop") {
                    withAnimation(Animation.linear(duration: 0.01)) {
                        seconds += 30
                    }
                    countdown -= 30
                }
                if countdown == 0 {
                    status = "Start"
                }
            })
            Text(GetFormattedTime(iSeconds: countdown))
            Spacer()
            Button(status) {
                if (status == "Start") {
                    if countdown == 0 {
                        section += 1
                        if (section > 8) {
                            section = 1;
                            colors = [Color](repeating: .primary, count: 8)
                        }
                        
                        seconds = 0
                        countdown = Double(getTimeSegment(section: section).rawValue) * 60
                    }
                    colors[section - 1] = .green
                    status = "Stop"
                    getLabel(section: section)
                } else {
                    
                    status = "Start"
                }
            }
            Button("Reset") {
                section = 1
                seconds = 0
                countdown = Double(getTimeSegment(section: section).rawValue) * 60
                status = "Start"
                colors = [Color](repeating: .primary, count: 8)
            }
            Spacer()
        }
        .padding()
    }
    
    func GetFormattedTime(iSeconds: Double) -> String {
        let minutes = Int(floor(iSeconds/60))
        let seconds = Int(Int(iSeconds)%60)
        
        return String(minutes) + ":" + ((seconds < 10) ? "0" : "") + String(seconds)
    }
    
    func getTimeSegment(section: Int) -> Sections {
        if section % 2 != 0 {
            return .work
        } else if section == 8 {
            return .long_break
        } else {
            return .short_break
        }
    }
    
    func getLabel(section: Int) {
        if section % 2 != 0 {
            phase = "Work"
        } else if section == 8 {
            phase = "Long Break"
        } else {
            phase = "Short Break"
        }
    }
}

enum Sections: Int {
    case work = 3
    case short_break = 1
    case long_break = 2
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

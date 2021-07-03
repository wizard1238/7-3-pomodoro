//
//  ContentView.swift
//  7-3-pomodoro
//
//  Created by Jeremy Tow on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var texts: String = "hello"
    
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

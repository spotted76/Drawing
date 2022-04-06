//
//  ContentView.swift
//  Drawing
//
//  Created by Peter Fischer on 4/2/22.
//

import SwiftUI

struct Arrow : InsettableShape {
    
    var thickness : Double
    var insetAmount = 0.0
    
    var rectWidth : Double {
        thickness * 0.75
    }
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - thickness, y: rect.maxY * 0.35 ))
        path.addLine(to: CGPoint(x:rect.midX + thickness, y: rect.maxY * 0.35))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        path.addRect(CGRect(x: rect.midX - (rectWidth / 2.0), y: rect.maxY * 0.35, width: rectWidth, height: rect.maxY * 0.65))
               
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ColorCyclingArrow: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Arrow(thickness: Double(value))
                    .inset(by: Double(value))
                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}



struct ContentView: View {

    @State private var thickness = 75.0

    var body: some View {
        
        VStack {
            ColorCyclingArrow(amount: 0.0, steps: Int(thickness))
            .frame(width: .infinity, height: 500)
         
            Spacer()
            Slider(value: $thickness, in: 0...150.0)
            Spacer()
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

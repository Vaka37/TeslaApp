//
//  customShapeView.swift
//  TeslaApp
//
//  Created by Vakil on 14.05.2024.
//

import SwiftUI


struct LogoTop: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX + 30, y: 110))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - 30, y: 110), control: CGPoint(x: rect.maxX / 2 , y: 80))
        
        path.addLine(to: CGPoint(x: rect.maxX - 50, y: 135))
        
        path.addQuadCurve(to: CGPoint(x: rect.minX + 50, y: 135), control: CGPoint(x: rect.maxX / 2 , y: 115))
        
        path.closeSubpath()
        
        return path
    }
}


struct LogoBottom: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX + 60, y: 170))
        
        path.addQuadCurve(to: CGPoint(x: rect.midX - 20, y: 160), control: CGPoint(x: (rect.maxX + 40) / 4 , y: 160))
        
        path.addLine(to: CGPoint(x: rect.midX, y: 180))
        
        path.addLine(to: CGPoint(x:rect.midX + 20, y: 160))
        
        path.addQuadCurve(to: CGPoint(x: rect.maxX - 60, y: 170), control: CGPoint(x:rect.maxX - 110 , y: 160))
        
        path.addQuadCurve(to: CGPoint(x: rect.maxX - 80, y: 195), control: CGPoint(x: rect.maxX - 79, y: 200))
        
        path.addQuadCurve(to: CGPoint(x: rect.midX + 30, y: 185), control: CGPoint(x: rect.maxX - 79, y: 180))
        
        path.addLine(to: CGPoint(x: rect.midX, y: 300))
        
        path.addLine(to:CGPoint(x: rect.midX - 30, y: 185))
        
        path.addQuadCurve(to: CGPoint(x: rect.minX + 80, y: 195), control: CGPoint(x: rect.minX + 70, y: 182))
        
        path.addQuadCurve(to: CGPoint(x: rect.minX + 60, y: 170), control: CGPoint(x: rect.minX + 75, y: 200))
        
        return path
    }
}

//
//  NeymorfismUnSelected.swift
//  TeslaApp
//
//  Created by Vakil on 14.05.2024.
//

import Foundation
import SwiftUI

struct NeymorfismUnSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 5, x: -5, y: -5)
            .shadow(color: .darkShadow, radius: 5, x: 5, y: 5 )
    }
}


struct NeymorfismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 5, x: 5, y: 5)
            .shadow(color: .darkShadow, radius: 5, x: -5, y: -5 )
    }
}

struct NeymorfismUnSelectedCircul: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color.background))
            .neymorfismUnSelectedStyle()
    }
}

extension View {
    func neymorfismUnSelectedStyle() -> some View {
        modifier(NeymorfismUnSelected())
    }
    
    func neymorfismSelectedStyle() -> some View {
        modifier(NeymorfismSelected())
    }
    
    func neymorfismUnSelectedCircul() -> some View {
        modifier(NeymorfismUnSelectedCircul())
    }
}

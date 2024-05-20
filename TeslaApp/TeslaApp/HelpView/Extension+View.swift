//
//  Extension+View.swift
//  TeslaApp
//
//  Created by Vakil on 15.05.2024.
//

import SwiftUI

extension View {
    func bacgroundStackView<Content: View>(isLock: Bool = false, content: () -> Content) -> some View {
        ZStack {
            if !isLock{
                Rectangle()
                    .fill(Color.background)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            } else {
                Rectangle()
                    .fill(LinearGradient(colors: [.background, .black, .bottomGradient], startPoint: .top, endPoint: .bottom))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
            content()
        }
    }
    
    func bacgroundBottomSheet<Content: View>(content: () -> Content) -> some View {
        ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Constant.bacGroundColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            content()
        }
    }
}

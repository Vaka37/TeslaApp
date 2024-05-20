//
//  NeyromorfismCirculeButtonView.swift
//  TeslaApp
//
//  Created by Vakil on 15.05.2024.
//

import SwiftUI


struct NeymorfismCirculButton: View {
    var action: (() -> Void)?
    var image: String
    var body: some View {
        Button {
            action?()
        } label: {
            Image(image)
                .renderingMode(.template)
                .neymorfismUnSelectedCircul()
                .shadow(color: .white.opacity(0.9), radius: -13, x: -20, y: 0)
                .overlay {
                    Circle()
                        .stroke(LinearGradient(colors: [.black.opacity(0.4), .white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottom), lineWidth: 1)
                }
        }
        
    }
}

#Preview {
    NeymorfismCirculButton(image: "settings")
        .preferredColorScheme(.dark)
}

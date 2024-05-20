//
//  BottomSheetView.swift
//  TeslaApp
//
//  Created by Vakil on 15.05.2024.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        bacgroundBottomSheet{
            VStack{
                Capsule()
                    .fill(Color.black)
                    .frame(width: 100, height: 4)
                    .padding(.top)
                Spacer()
                content()
            }
        }
            .frame(height: UIScreen.main.bounds.height + 300)
            .offset(y: UIScreen.main.bounds.height)
            .offset(y: currentMenuOffsetY)
            .gesture(gesture)
        
        .ignoresSafeArea()
    }
    @GestureState private var gestureOffset: CGSize = .zero
    @State private var currentMenuOffsetY: CGFloat = .zero
    @State private var lastMenuOffsetY: CGFloat = .zero
    
    private var gesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, transaction in
                state = value.translation
                onChangeMenuOffset()
            }
            .onEnded { value in
                let maxHeigh = UIScreen.main.bounds.height - 100
                withAnimation {
                    if -currentMenuOffsetY > maxHeigh / 6 {
                        currentMenuOffsetY = -maxHeigh / 6
                    } else {
                        currentMenuOffsetY = 0
                    }
                    lastMenuOffsetY = currentMenuOffsetY
                }
            }
    }
    
    private func onChangeMenuOffset() {
        DispatchQueue.main.async {
            currentMenuOffsetY = gestureOffset.height + lastMenuOffsetY
        }
    }
}

#Preview {
    BottomSheetView(content: {
        StartView()
    })
}

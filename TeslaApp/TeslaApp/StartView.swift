//
//  StartView.swift
//  TeslaApp
//
//  Created by Vakil on 14.05.2024.
//

import Foundation
import SwiftUI

struct StartView: View {
    var body: some View {
        bacgroundStackView(isLock: isCarClose) {
            VStack {
                settingsButton
                header
                carView
                Spacer()
                    .frame(height: 110)
                closeCarControl
            }
        }.fullScreenCover(isPresented: $isShowSettingsView, content: {
            TabBarView()
        })
    }
    
    @State private var isCarClose = true
    @State private var isShowSettingsView = false
    
    private var settingsButton: some View {
        HStack {
            Spacer()
            NeymorfismCirculButton(action: {
                isShowSettingsView.toggle()
            }, image: "settings")
                .foregroundColor(.gray)
        }
        .padding(.trailing, 30)
    }
    
    
    private var header: some View {
        VStack {
            Text(!isCarClose ? "Hi" : "")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .transition(.scale)
            Text(!isCarClose ? "Welcome Back" : "")
                .font(.system(size: 41))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
    }
    
    private var carView: some View {
        Image(isCarClose ? "closeCar" : "car")
            .resizable()
            .frame(height: 250)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: !isCarClose ? .gradientTop.opacity(0.4) : .clear, radius: 30, x: 0, y: 0)
            .offset(x: isCarClose ? 0 : 0, y: isCarClose ? -10 : 0)
    }
    
    private var closeCarControl: some View {
        Button {
            withAnimation(.spring) {
                isCarClose.toggle()
            }
        } label: {
            HStack {
                Text(isCarClose ? "Unlock" : "Lock")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .tint(.white)
                Spacer()
                    .frame(width: 40)
                NeymorfismCirculButton(action: {
                    withAnimation(.spring) {
                        isCarClose.toggle()
                    }
                }, image: isCarClose ? "unlock" : "lock")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color.background))
            .neymorfismSelectedStyle()
        }
        
        .overlay(content: {
            RoundedRectangle(cornerRadius: 50)
                .stroke(LinearGradient(colors: [.black.opacity(0.9), .white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            
        })
        .frame(minWidth: 300)
    }
}

#Preview {
    StartView()
        .preferredColorScheme(.dark)
}


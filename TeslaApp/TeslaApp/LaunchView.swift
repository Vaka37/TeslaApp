//
//  LaunchView.swift
//  TeslaApp
//
//  Created by Vakil on 13.05.2024.
//

import SwiftUI

struct LaunchView: View {
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(colors: [.topGradient, .bottomGradient], startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    logoTop
                    logoBottom
                }
                .offset(y: transition ? 0 : 200)
                .transition(.slide)
                Spacer()
            }
        }.onAppear(){
            withAnimation(.linear(duration: 1)) {
                animation.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    withAnimation(.linear(duration: 0.7)) {
                        transition.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        isShowStartView = true
                    })
                })
            }
        }
        .fullScreenCover(isPresented: $isShowStartView, content: {
            StartView()
        })
    }
    
    @State private var isShowStartView = false
    @State private var animation = true
    @State private var transition = true
    
    private var logoTop: some View {
        LogoTop()
            .fill(.gray.opacity(0.4))
            .overlay {
                LogoTop()
                    .stroke(LinearGradient(colors: [.black, .clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
                    .blur(radius: 5)
                    .frame(width: 396)
            }
            .overlay {
                ShineBorderAnimation()
            }
            .rotationEffect(.degrees(animation ? -180 : 0))
            .offset(x: animation ? -400 : 0)
    }
    
    private var logoBottom: some View {
        LogoBottom()
            .fill(.gray.opacity(0.4))
            .overlay {
                LogoBottom()
                    .stroke(LinearGradient(colors: [.black, .clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
                    .blur(radius: 5)
                    .frame(width: 395)
            }
            .overlay {
                ShineBorder()
            }
            .rotationEffect(.degrees(animation ? 180 : 0))
            .offset(x: animation ? 400 : 0)
            .frame(width: animation ? -100 : 400)
    }
}

#Preview {
    LaunchView()
        .preferredColorScheme(.dark)
}

struct ShineBorderAnimation: View {
    @State private var gradient: [Color]
    @State private var startPoint = UnitPoint(x: 0, y: 0)
    @State private var endPoint = UnitPoint(x: 0, y: 0)
    
    init(gradient: [Color] = [Color.blue.opacity(0.5), Color.blue.opacity(0.5), .clear]) {
        self.gradient = gradient
    }
    
    var body: some View {
        VStack {
            LogoTop()
                .stroke(LinearGradient(gradient: Gradient(colors: gradient),
                                       startPoint: self.startPoint,
                                       endPoint: self.endPoint),
                        lineWidth: 1)
                .onAppear {
                    withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                        self.startPoint = UnitPoint(x: 0, y: 0)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
                }
        }
    }
}

struct ShineBorder: View {
    @State private var gradient: [Color]
    @State private var startPoint = UnitPoint(x: 0, y: 0)
    @State private var endPoint = UnitPoint(x: 0, y: 0)
    
    init(gradient: [Color] = [Color.blue.opacity(0.5), Color.blue.opacity(0.5), .clear]) {
        self.gradient = gradient
    }
    
    var body: some View {
        VStack {
            LogoBottom()
                .stroke(LinearGradient(gradient: Gradient(colors: gradient),
                                       startPoint: self.startPoint,
                                       endPoint: self.endPoint),
                        lineWidth: 1)
                .onAppear {
                    withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                        self.startPoint = UnitPoint(x: 0, y: 0)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
                }
        }
    }
}

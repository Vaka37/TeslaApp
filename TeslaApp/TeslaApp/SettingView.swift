//
//  ContentView.swift
//  TeslaApp
//
//

import SwiftUI

struct SettingView: View {
    @State var action: ((Int) -> ())?
    var body: some View {
        NavigationView{
            bacgroundStackView {
                VStack {
                    header
                    carView
                    panelView
                    Spacer()
                }
            }
        }
    }
    
    @State private var isCarClose = false
    @State private var tadSelecteded = 0
    
    var header: some View {
        HStack {
            HStack {
                VStack(alignment: .leading, content: {
                    Text("Tesla")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    HStack {
                        Image(systemName: "battery.75percent")
                            .foregroundColor(.gray)
                        Text("187 KM")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .opacity(0.4)
                    }
                })
                Spacer()
            }
            NeymorfismCirculButton(image: "user")
                .tint(Color.gray)
        }
        .padding(25)
    }
    
    private var carView: some View {
        Image("carTesla")
            .resizable()
            .frame(height: 250)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .gray.opacity(0.4), radius: 30, x: 0, y: 0)
        
    }
    
    private var panelView: some View {
        HStack(spacing: 30, content: {
            ForEach(1..<5){index in
                if index == 2 {
                    NavigationLink {
                        ClimateView()
                    } label: {
                        Image("\(index)")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .neymorfismUnSelectedCircul()
                            .overlay {
                                Circle()
                                    .stroke(lineGradient, lineWidth: 2)
                                    .opacity(tadSelecteded == index ? 1 : 0)
                            }
                    }
                } else {
                    Button {
                        withAnimation {
                            tadSelecteded = index
                        }
                    } label: {
                        Image("\(index)")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .neymorfismUnSelectedCircul()
                            .overlay {
                                Circle()
                                    .stroke(lineGradient, lineWidth: 2)
                                    .opacity(tadSelecteded == index ? 1 : 0)
                            }
                    }
                }
            }
        })
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color.background))
        .neymorfismUnSelectedStyle()
        .onAppear() {
            withAnimation {
                action?(1)
            }
        }
        .onDisappear() {
            withAnimation {
                action?(0)
            }
            tadSelecteded = 0
        }
    }

    private var lineGradient: LinearGradient {
        LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .bottom, endPoint: .top)
    }
}

#Preview {
    SettingView()
        .environment(\.colorScheme, .dark)
}

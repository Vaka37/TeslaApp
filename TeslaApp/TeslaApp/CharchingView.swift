//
//  CharchingView.swift
//  TeslaApp
//
//  Created by Vakil on 16.05.2024.
//

import SwiftUI

struct CharchingView: View {
    @State private var value = 0
    @State private var offset = 100.0
    @State private var colorOne = Color.topCh
    @State private var colorTwo = Color.bottomCh
    @State private var closeMenu = false
    @State private var isExpanded = false
    var body: some View {
        NavigationView{
            bacgroundStackView {
                VStack {
                    Spacer()
                    carView
                    progressCharhing
                    Spacer()
                        .frame(height: 100)
                    panelSuperchargersView
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("CLIMATE")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing){
                    NeymorfismCirculButton(action: {
                        
                    }, image: "settings")
                    .tint(Color.gray)
                }
            })
        }
    }
    
    private var carView: some View {
        Image("tesla")
            .resizable()
            .frame(width: .infinity,height: 220)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .gray.opacity(0.4), radius: 30, x: 0, y: 0)
    }
    
    private var progressCharhing: some View {
        VStack {
            ZStack(alignment: .trailing) {
                CustomSliderCahrging(value: $value, offset: $offset, colorOne: $colorOne, colorTwo: $colorTwo, imageCircle: "treangle")
                    .frame(width: 275)
                HStack {
                    VStack {
                        Rectangle()
                            .fill(colorOne)
                            .frame(width: 3, height: 14)
                            .offset(x: 13)
                        Text("75%")
                            .foregroundColor(value < 75 ? .white : .gray)
                            .font(.system(size: 14))
                    }
                    Spacer().frame(width: 40)
                    
                    VStack {
                        Rectangle()
                            .fill(colorOne)
                            .frame(width: 3, height: 14)
                            .offset(x: 13)
                        Text("100%")
                            .foregroundColor(value > 75 ? .white : .gray)
                            .font(.system(size: 14))
                    }
                }
                .offset(y: 55)
                .padding(.trailing, 2)
            }
        }
        .padding(.top, -50)
    }
    private var panelSuperchargersView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.clear)
                .frame(width: 338, height: 130)
                .overlay {
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(.gray, lineWidth: 10)
                        .shadow(color: .black.opacity(0.8), radius: 6, x: 6, y: 6)
                        .shadow(color: .white.opacity(0.1), radius: 5, x: -5, y: -5)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0).inset(by: 5.5))
                    HStack {
                        Text("Nearby Superchargers")
                            .font(.system(size: 24).bold())
                        
                        Spacer()
                            .frame(width: 20)
                        NeymorfismCirculButton(image: "back")
                            .tint(.gray)
                    }
                }
        }
    }
}

#Preview {
    CharchingView()
        .preferredColorScheme(.dark)
}

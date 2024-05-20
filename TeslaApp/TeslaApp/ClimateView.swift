//
//  ClimateView.swift
//  TeslaApp
//
//  Created by Vakil on 15.05.2024.
//

import SwiftUI

struct ClimateView: View {
    //MARK: - Private Properties
    
    private var settngsTitle = ["Ac", "Fan", "Heat", "Auto"]
    
    var body: some View {
        bacgroundStackView {
            ZStack {
                VStack{
                    circuleTempView
                    climatePanel
                }
                BottomSheetView {
                    VStack {
                        bottomSheetControl
                        Spacer()
                    }
                }
                if isShowAlert {
                    alertView
                        .transition(.move(edge: .trailing).combined(with: .move(edge: .top)).combined(with: .scale).combined(with: .opacity))
                        .zIndex(1)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("CLIMATE")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading){
                NeymorfismCirculButton(action: {
                    dismiss()
                }, image: "back")
                .tint(Color.gray)
            }
            ToolbarItem(placement: .topBarTrailing){
                
                NeymorfismCirculButton(action: {
                    withAnimation {
                        isShowAlert.toggle()
                    }
                }, image: "settings")
                .tint(Color.gray)
            }
        })
    }
    
    @Environment (\.dismiss) private var dismiss
    @State private var temperature = [15, 15, 15, 15]
    @State private var tagSegmented = 0
    @State private var value = 15
    @State private var progress = 0.0
    @State private var values = [0.0, 0.0, 0.0, 0.0]
    @State private var startSettings = false
    @State private var selectedColor = Color.blue
    @State private var isShowAlert = false
    private var circuleTempView: some View {
        ZStack {
            Circle()
                .fill(Constant.bacGroundColor)
                .frame(width: 192)
                .shadow(color: .white.opacity(0.2), radius: 30, x: -20, y: -15)
                .shadow(color: .black.opacity(0.6), radius: 30, x: 20, y: 15)
            Circle()
                .fill(Constant.bacGroundColor)
                .frame(width: 120)
                .overlay {
                    Circle()
                        .stroke(LinearGradient(colors: [.black, .white.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                    Circle()
                        .fill(LinearGradient(colors: [.bottomGradient.opacity(0.5), .topGradient], startPoint: .leading, endPoint: .bottomTrailing))
                }
            circleAnimationView
                .offset(y: 10)
            
            Text(startSettings ? "\(temperature[tagSegmented])° C" : " ")
                .font(.system(size: 44).monospacedDigit())
                .foregroundColor(.gray)
        }
    }
    
    private var climatePanel: some View {
        DisclosureGroup("") {
            VStack(spacing: 15) {
                ForEach(0..<4) { index in
                    HStack {
                        Text(settngsTitle[index])
                            .foregroundColor(.gray)
                        Spacer()
                        NeymorfismCirculButton(action: {
                            tagSegmented = index
                        }, image: settngsTitle[index])
                        .foregroundColor(tagSegmented == index ? .blue : .gray)
                        Spacer()
                        CustomSliderView(value: $temperature[index], minValue: 15, maxValue: 30, chengedValue: $value, circleProgree: $progress, offset: $values[index], color: selectedColor)
                            .frame(width: 200)
                    }
                    .padding()
                }
            }
        }
        .padding(.trailing, 20)
    }
    
    private var circleAnimationView: some View {
        Circle()
            .trim(from: 0, to: CGFloat(values[tagSegmented] - 15) / 160)
            .stroke(selectedColor, style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .offset(x: 7)
            .frame(height: 215)
            .rotationEffect(.degrees(-90))
            .shadow(color: Color.white, radius: 10)
    }
    
    private var bottomSheetControl: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading) {
                    Text("A/C is ON")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Tap to turn off or swipe up \nfor a fast setup")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                Button {
                    withAnimation(.linear) {
                        startSettings.toggle()
                    }
                } label: {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 75)
                        .shadow(color: .black, radius: 10, x: 3, y: 5)
                        .overlay {
                            Circle()
                                .stroke(LinearGradient(colors: [.white.opacity(0.6), .black.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
                                .shadow(color: .white, radius: 10, x: -3, y: -5)
                            Circle()
                                .fill(LinearGradient(colors: [.black.opacity(0.45), .white.opacity(0.35)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 70)
                            
                            Image(systemName: "power")
                                .tint(.white)
                        }
                }
            }
            stepperView
                .padding(.bottom)
            HStack {
                Text("On")
                Spacer()
                Text("Vent")
            }
            .foregroundColor(.gray)
            .padding(.horizontal, 60)
        }
        .padding(.top)
    }
    
    private var stepperView: some View {
        HStack {
            Spacer()
            colorSettingsView
            Spacer()
            stepperButton(actionButton: {
                guard temperature[tagSegmented] > 15 && temperature[tagSegmented] < 31 else {return}
                temperature[tagSegmented] -= 1
                values[tagSegmented] -= 12
            }, nameImage: "chevron.left")
            Text("\(temperature[tagSegmented])°")
                .font(.system(size: 30).monospacedDigit())
                .fontWeight(.bold)
                .foregroundColor(.white.opacity(0.7))
            stepperButton(actionButton: {
                guard temperature[tagSegmented] < 30 else {return}
                temperature[tagSegmented] += 1
                values[tagSegmented] += 12
            }, nameImage: "chevron.right")
            Spacer()
            Image("Union")
                .tint(.gray)
            Spacer()
        }
    }
    
    private func stepperButton(actionButton: (() -> ())?, nameImage: String ) -> some View {
        HStack {
            Button(action: {
                actionButton?()
            }, label: {
                Image(systemName: nameImage)
                    .tint(.gray)
            })
        }
    }
    
    private var colorSettingsView: some View {
        ColorPicker("", selection: $selectedColor)
            .accentColor(.black)
            .frame(width: 10)
    }
    
    private var alertView: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [.topGradient.opacity(0.4), .bottomGradient], startPoint: .bottom, endPoint: .top))
                    .frame(width: 250, height: 150)
                VStack {
                    Text("Tesla Support")
                        .font(.title2.bold())
                        .padding(.vertical)
                    Text("https://www.tesla.com/support")
                }
            }
    }
}

#Preview {
    ClimateView()
        .preferredColorScheme(.dark)
}

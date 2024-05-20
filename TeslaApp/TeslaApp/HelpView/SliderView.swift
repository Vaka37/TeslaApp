//
//  TeslaApp
//
//

import SwiftUI

struct CustomSliderView: View {
    var color: Color = .white
    @Binding private var value: Int
    @Binding var offset: Double
    @Binding var chengedValue: Int
    @Binding var circleProgress: Double
    @State private var lastOffset = 0.0
    private let minValue: Int
    private let maxValue: Int
    private let step = 1
    
    init(value: Binding<Int>, minValue: Int, maxValue: Int, chengedValue: Binding<Int>, circleProgree: Binding<Double>, offset: Binding<Double>, color: Color) {
        _value = value
        self.minValue = minValue
        self.maxValue = maxValue
        _chengedValue = chengedValue
        _circleProgress = circleProgree
        _offset = offset
        self.color = color
    }
    
    var body: some View {
        GeometryReader { reader in
            let maxSliderWidth = reader.size.width - 16
            
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [.black, .white.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(height: 10)
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [.black, color]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: offset, height: 10)
                    Image("slider")
                        .frame(width: 10)
                        .offset(x: offset, y: 5)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ dragValue in
                                    var translation = dragValue.translation.width + lastOffset
                                    translation = min(max(translation, 0), maxSliderWidth)
                                    let dragPercent = getDragPercent(translation: translation, of: maxSliderWidth)
                                        let valueNum = dragPercentToValue(dragPercent: dragPercent)
                                    withAnimation {
                                        offset = valueToFillPercent(valueNum) * maxSliderWidth
                                    }
                                    value = valueNum
                                })
                                    
                                .onEnded({ _ in
                                    lastOffset = offset
                                })
                        )
                }
                .frame(height: 16)
            }
        }
        .frame(maxHeight: 30)
    }
    
    private func getDragPercent(translation: CGFloat, of maxWidth: CGFloat) -> CGFloat {
        translation / maxWidth
    }
    
    private func dragPercentToValue(dragPercent: CGFloat) -> Int {
        let actualValue = Int(dragPercent * Double(maxValue - minValue) + Double(minValue))
        let remainder = actualValue % step
        var roundedValue = actualValue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if remainder < step / 2 {
                roundedValue = actualValue - remainder
            } else {
                roundedValue = actualValue - remainder + step
            }
        }
        return Int(roundedValue)
    }
    
    private func valueToFillPercent(_ result: Int) -> CGFloat {
        Double(result - minValue) / Double((maxValue - minValue))
    }
    
}


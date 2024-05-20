//
//  TabBarView.swift
//  TeslaApp
//
//  Created by Vakil on 16.05.2024.
//

import SwiftUI

struct TabItemPreferencyKey: PreferenceKey {
    static var defaultValue: [TabItem] = []
    
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}

struct TabBarModifire: ViewModifier {
    let tabBarItem: TabItem
    
    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferencyKey.self, value: [tabBarItem])
    }
}

struct CustomTabView<Content: View> : View {
    @Binding var selection: Int
    @Binding var opacity: Int
    
    @State private var tabs : [TabItem] = [.init(icon: "car.rear.fill"), .init(icon: "bolt.fill"), .init(icon: "mappin.and.ellipse"), .init(icon: "person.fill")]
    
    private var content: Content
    
    init(selection: Binding<Int>, @ViewBuilder content: () -> Content, opacity: Binding<Int>) {
        _selection = selection
        self.content = content()
        _opacity = opacity
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            content
            HStack{
                tabsView
            }
            .padding(.vertical, 5)
            .ignoresSafeArea()
            .background(
                TabBarShape()
                    .fill(LinearGradient(colors: [.background, .black, .bottomGradient], startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .overlay(content: {
                        TabBarShape()
                            .stroke(LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                            .ignoresSafeArea()
                        TabBarShape()
                            .stroke(LinearGradient(colors: [.white.opacity(0.4), .black], startPoint: .top, endPoint: .bottom), lineWidth: 2)
                            .shadow(radius: 10, y: -1)
                            .ignoresSafeArea()
                    })
            )
            .opacity(Double(opacity))
            plusTabBarButton
            .offset(y: -50)
            .opacity(Double(opacity))

        }
        .onPreferenceChange(TabItemPreferencyKey.self, perform: { value in
            self.tabs = value
        })
    }
    
    @Namespace private var tabBarItem
    
    private var tabsView: some View {
        ForEach(Array(tabs.enumerated()), id: \.offset) { index, element in
            Spacer()
            Image(systemName: element.icon)
                .foregroundColor(selection == index ? .gradientTop : .gray)
                .background(
                    ZStack {
                        if selection == index {
                            Circle()
                                .fill(.gradientTop.opacity(0.3))
                                .shadow(color: .gradientTop.opacity(0.7), radius: 20)
                                .blur(radius: 10)
                                .frame(width: 50, height: 50)
                                .matchedGeometryEffect(id: "tabBar", in: tabBarItem)
                        }
                    }
                )
                .onTapGesture {
                    withAnimation {
                        selection = index
                    }
                }
            Spacer()
        }
    }
    
    private var plusTabBarButton: some View {
        Button {
            
        } label: {
            Image("plusIcon")
        }
                .background {
                    Circle()
                        .fill(LinearGradient(colors: [.topGradient, .bottomGradient], startPoint: .top, endPoint: .bottom))
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .stroke(LinearGradient(colors: [.gray.opacity(0.6), .black.opacity(0.3)], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                
        }
    }
}

struct TabBarView: View {
    @State private var selection = 0
    @State private var opacity = 1
    var body: some View {
        CustomTabView(selection: $selection, content: {
            SettingView(action: { value in
                opacity = value
            })
                .myTabItem {
                    TabItem(icon: "car.rear.fill")
                }
                .opacity(selection == 0 ? 1 : 0)
            CharchingView()
                .myTabItem {
                    TabItem(icon: "bolt.fill")
                }
                .opacity(selection == 1 ? 1 : 0)
                bacgroundStackView {
                    VStack {
                    }
                }
                .myTabItem {
                    TabItem(icon: "mappin.and.ellipse")
                }
                .opacity(selection == 2 ? 1 : 0)
            bacgroundStackView {
                VStack {
                }
            }
                .myTabItem {
                    TabItem(icon: "person.fill")
                }
                .opacity(selection == 3 ? 1 : 0)
        }, opacity: $opacity)
    }
}

#Preview {
    TabBarView()
        .preferredColorScheme(.dark)
}


extension View {
    func myTabItem(_ label: () -> TabItem) -> some View {
        modifier(TabBarModifire(tabBarItem: label()))
    }
}

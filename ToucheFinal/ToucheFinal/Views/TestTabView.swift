//
//  TestTabView.swift
//  ToucheFinal
//
//  Created by TAEHYOUNG KIM on 2023/02/01.
//


import SwiftUI

struct TestTabView: View {
    
    @State private var selectedIndex = 0
    @State private var touchTab = false
    @State var isShowingOnboardingView: Bool = UserDefaults.standard.bool(forKey: "isShowingOnboardingView")
    
    let tabBarNames = ["Home", "Palette", "Profile"]
    var body: some View {
        
//        TabView(selection: $selectedIndex) {
//            Text("1").tabItem {
//                VStack {
//                    Text("1")
//                    Circle()
//                        .foregroundColor(Color(.black))
//                        .frame(width: 101, height: 4)
//                }
//            }
//            Text("2").tabItem {
//                Text("2")
//            }
//            Text("3").tabItem {
//                Text("3")
//            }
//
//        }
        
        
//        GeometryReader{geometry in
            if isShowingOnboardingView {
                OnboardingView(isShowingOnboardingView: $isShowingOnboardingView)
            } else {
                VStack{
                    ZStack() {
                        switch selectedIndex{
                        case 0:
                            HomeView()
                        case 1:
                            PaletteView()
                        default:
                            LogInRootView()
                        }
                    }
                    Spacer()
                    Divider()
                        .offset(y: -6)
                    HStack{
                        Spacer()

                        ForEach(0..<3) { num in
                            VStack(alignment: .center){
                                Text(tabBarNames[num])
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(selectedIndex == num ? Color(.black) : Color(.tertiaryLabel))
                            }
                            .gesture(
                                TapGesture()
                                    .onEnded { _ in
                                        selectedIndex = num
                                    }
                            )

                            Spacer()
                        }
                    }
//                    .padding(.top, 12)

//                    HStack{
//                        switch selectedIndex{
//                        case 0 :
//                            Circle()
//                                .foregroundColor(Color(.black))
////                                .frame(width: 101, height: 4)
////                                .padding(.leading, geometry.size.width / -2.4)
//                        case 1:
//                            Circle()
//                                .foregroundColor(Color(.black))
////                                .frame(width: 101, height: 4)
////                                .padding(.leading, geometry.size.width / -50)
//
//                        case 2:
//                            Circle()
//                                .foregroundColor(Color(.black))
////                                .frame(width: 101, height: 4)
////                                .padding(.leading, geometry.size.width / 1.8)
//                        default :
//                            Circle()
//                                .foregroundColor(Color(.black))
////                                .frame(width: 101, height: 4)
//                        }
//                    }
//                    .padding(.top, -5)
                }
            }
//        }
    }
}


struct TestTabView_Previews: PreviewProvider {
    static var previews: some View {
        TestTabView()
            .environmentObject(ColorPalette())
            .environmentObject(PerfumeStore())
            .environmentObject(UserInfoStore())
    }
}

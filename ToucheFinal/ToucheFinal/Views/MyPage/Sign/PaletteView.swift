//
//  TESTVIEWTS.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/01/31.
//

import SwiftUI

struct PaletteView: View {
    @State private var angle: Angle = .zero
    @State private var radius: CGFloat = 140.0
    @State private var animation: Animation? = nil
    @State private var txt = ""
    @State private var isTapped = false
    @State private var scentTypeCount: [String: Int] = [:]
    @State private var selectedColor: Color = Color("customGray")
    @State var isSignin: Bool = false
    @State var navLinkActive = false
    
    @EnvironmentObject var colorPaletteCondition: ColorPalette
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("My Perfume Palette")
                        .font(.largeTitle)
                        .padding(.bottom, 40)
                        .fontWeight(.semibold)
                    
                    ZStack {
                        // MARK: - 팔레트 테두리 색
                        Group{
                            ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                                PalletteCell(
                                    color: color.color,
                                    degrees: Double(index) * 22.5,
                                    name: color.name,
                                    count: scentTypeCount[color.name] ?? 1)
                                .rotationEffect(Angle(degrees: -79))
                                .opacity(isTapped ? 1 : 1)
                            }
                        }
                        .clipShape(
                            Circle()
                                .stroke(lineWidth: 110)
                        )
                        
                        // MARK: - 팔레트 눌렀을때 나오는 가운데 부분
                        ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(color.color)
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Text("\(String(color.name.prefix(13)))")
                                        .font(.system(size: 12))
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                .opacity(isTapped ? color.name == txt ? 1 : 0 : 0)
                                .animation(.linear(duration: 0.5), value: txt)
                        }
                        
                        // MARK: - 팔레트 글씨
                        Wheel(radius: radius, rotation: angle, pointToCenter: true) {
                            ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                                WheelComponent(animation: animation) {
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(color.color.opacity(0))
                                        .frame(width: 70, height: 70)
                                        .overlay {
                                            Text("\(String(color.name.prefix(15)))")
                                                .font(.system(size: 12))
                                                .bold()
                                                .foregroundColor(.white)
                                                .padding(.bottom, 30)
                                                .padding(.horizontal, 6)
                                        }
                                }
                                .opacity(isTapped ? color.name == txt ? 0 : 1 : 1)
                                .onTapGesture {
                                    colorPaletteCondition.selectedColor = color.color
                                    colorPaletteCondition.selectedCircle = color.color
                                    txt = color.name
                                    isTapped = true
                                }
                            }
                        } // wheel 끝
                    }
                    
                    HStack {
                        Text("Scent Type")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("customGray"))
                        .overlay (
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus bibendum nulla libero, vel accumsan sapien blandit ac. Donec nunc ligula, imperdiet eu massa ac, vehicula faucibus neque.")
                                .padding()
                                .background(Color("customGray"))
                                .cornerRadius(10)
                        )
                        .frame(height: 150)
                    
                    HStack {
                        Text("Wish List")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    if userInfoStore.user != nil {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(dummy, id: \.self.perfumeId) { perfume in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)                            } label: {
                                        ColorChipPerfumeCell(perfume: perfume)
                                    }
                            }
                        }
                    } else {
                        Spacer()
                        Spacer()
                        HStack {
                            Spacer()
                            Image("love")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("If you sign in...")
                                    .padding(.bottom, 10)
                                Text("You can collect only your favorite products.")
                            }
                            .frame(width: 200)
                            Spacer()
                        }
                        .onTapGesture(perform: {
                            isSignin.toggle()
                        })
                        .alert(
                        """
                        If you want to use Liked / Comments,
                        Please sign in
                        """
                        ,isPresented: $isSignin
                        ) {
                            Button("Cancel", role: .cancel) {}
                            Button {
                                navLinkActive = true
                            } label: {
                                Text("Sign In")
                            }
                        }
                        
                    }
                }
                .padding()
                .zIndex(1)
                ZStack {
                    ColorPaletteUnderView()
                }
            }
            .modifier(SignInFullCover(isShowing: $navLinkActive))
            .padding(.top, 0.1)
            .onAppear {
                for perfume in dummy {
                    scentTypeCount[perfume.scentType] = (scentTypeCount[perfume.scentType] ?? 0) + 1
                }
            }
        }
    }
}

struct Rotation: LayoutValueKey {
    static let defaultValue: Binding<Angle>? = nil
}

struct WheelComponent<V: View>: View {
    var animation: Animation? = nil
    @ViewBuilder let content: () -> V
    @State private var rotation: Angle = .zero
    
    var body: some View {
        content()
            .rotationEffect(rotation)
            .layoutValue(key: Rotation.self, value: $rotation.animation(animation))
    }
}

struct Wheel: Layout {
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(rotation.radians, radius)
        }
        set {
            rotation = Angle.radians(newValue.first)
            radius = newValue.second
        }
    }
    
    var radius: CGFloat
    var rotation: Angle
    var pointToCenter = false
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        
        let maxSize = subviews.map { $0.sizeThatFits(proposal) }.reduce(CGSize.zero) {
            
            return CGSize(width: max($0.width, $1.width), height: max($0.height, $1.height))
            
        }
        
        return CGSize(width: (maxSize.width / 2 + radius) * 2,
                      height: (maxSize.height / 2 + radius) * 2)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let angleStep = (Angle.degrees(360).radians / Double(subviews.count))
        
        for (index, subview) in subviews.enumerated() {
            let angle = angleStep * CGFloat(index) + rotation.radians
            
            // Find a vector with an appropriate size and rotation.
            var point = CGPoint(x: 0, y: -radius).applying(CGAffineTransform(rotationAngle: angle))
            
            // Shift the vector to the middle of the region.
            point.x += bounds.midX
            point.y += bounds.midY
            
            // Place the subview.
            subview.place(at: point, anchor: .center, proposal: .unspecified)
            
            DispatchQueue.global().async {
                if pointToCenter {
//                    subview[Rotation.self]?.wrappedValue = .radians(angle)
                } else {
                    subview[Rotation.self]?.wrappedValue = .zero
                }
            }
        }
    }
}


struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView()
            .environmentObject(ColorPalette())
            .environmentObject(UserInfoStore())
    }
}

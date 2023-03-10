//
//  LogInSignUpView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI
import SegmentedPicker

struct LogInSignUpView: View {
    @State var selectedIndex: Int?
    @Binding var user: Bool
    let titles: [String] = ["Sign In", "Sign Up"]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                SegmentedPicker(
                    titles,
                    selectedIndex: Binding(
                        get: { selectedIndex },
                        set: { selectedIndex = $0}),
                    selectionAlignment: .bottom,
                    content: { item, isSelected in
                        Text(item)
                            .foregroundColor(isSelected ? Color.black : Color.gray )
                            .font(.title2)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    },
                    selection: {
                        VStack(spacing: 0) {
                            Spacer()
                            Color.black.frame(height: 1)
                        }
                    })
                .onAppear {
                    
                }
                .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                Spacer()
            }
            .padding(.leading, 15)
       
            VStack {
                switch selectedIndex {
                case 0:
                    LogInView(user: $user)
                default:
                    SignUpView(user: $user)
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: 650)
            
        }
    }
}

struct LogInSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LogInSignUpView(user: .constant(true))
    }
}

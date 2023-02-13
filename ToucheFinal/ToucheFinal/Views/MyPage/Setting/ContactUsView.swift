//
//  ContactUsView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/13.
//

import SwiftUI

struct ContactUsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
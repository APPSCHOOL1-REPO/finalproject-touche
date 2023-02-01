//
//  MyCommentListView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/20.
//

import SwiftUI

struct MyCommentListView: View {
    var body: some View {
        VStack{
            Spacer()
            List {
                ForEach(0..<10) { _ in
                    VStack{
                        MyPageMyCommentCell(perfume: dummy[0], comment: commentDummy[0])
                            .padding(.bottom, 30)
                    }
                }
                .frame(height: 80)
                .navigationTitle("My Comment")
            }
            .listStyle(.plain)
            Spacer()
        }
    }
}

struct MyCommentListView_Previews: PreviewProvider {
    static var previews: some View {
        MyCommentListView()
    }
}

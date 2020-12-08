//
//  CommentView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct CommentView: View {
    var body: some View {
        VStack {
            ScrollView {
              ForEach(1..<10) { _ in
                CommentRow().padding(.bottom, 10)
              }
            }
            CommentInput()
        }.padding(.top, 15)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}

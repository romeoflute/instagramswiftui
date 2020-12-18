//
//  CommentView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var commentInputViewModel = CommentInputViewModel()
    
    @State var composedMessage: String = ""
    
    init(post: Post) {
        commentInputViewModel.post = post
    }
    var body: some View {
        VStack {
            ScrollView {
              ForEach(1..<10) { _ in
                CommentRow().padding(.bottom, 10)
              }
            }
            CommentInput(post: commentInputViewModel.post)
        }.padding(.top, 15)
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}

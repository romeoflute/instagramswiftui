//
//  CommentView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var commentViewModel = CommentViewModel()

    var post: Post!
    
//    init(post: Post) {
//        commentViewModel.post = post
//        commentViewModel.loadComments()
//    }
    
    var body: some View {
        VStack {
            ScrollView {
                if !commentViewModel.comments.isEmpty {
                    ForEach(commentViewModel.comments) { comment in
                       CommentRow(comment: comment)
                        .padding(.bottom, 10)
                   }
                }
            }
            CommentInput(post: post)
        }
        .padding(.top, 15)
        .onAppear {
            self.commentViewModel.post = self.post
            self.commentViewModel.loadComments()
        }
        .onDisappear {
            if self.commentViewModel.listener != nil {
                self.commentViewModel.listener.remove()
            }
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}

//
//  FooterCell.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI
import URLImage

struct FooterCell: View {
    @ObservedObject var footerCellViewModel = FooterCellViewModel()
    
    init(post: Post) {
        self.footerCellViewModel.post = post
        self.footerCellViewModel.checkPostIsLiked()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: (self.footerCellViewModel.isLiked) ? "heart.fill" : "heart").onTapGesture {
                    if self.footerCellViewModel.isLiked {
                        self.footerCellViewModel.unlike()
                    } else {
                        self.footerCellViewModel.like()
                    }
                }
                NavigationLink(destination: CommentView(post: self.footerCellViewModel.post)) {
                    Image(systemName: "bubble.left").renderingMode(.original)
                }
                
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark.fill")
            }
            .padding(.trailing, 15)
            .padding(.leading, 15)
            
            if footerCellViewModel.post.likeCount > 0 {
                Text("\(footerCellViewModel.post.likeCount) \(self.footerCellViewModel.post.likeCount > 1 ? "likes" : "like")")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .padding(.top, 5)
            }
            
            HStack {
                Text(footerCellViewModel.post.username)
                    .font(.subheadline)
                    .bold()
                Text(footerCellViewModel.post.caption)
                    .font(.subheadline)
            }
            .padding(.leading, 15)
            NavigationLink(destination: CommentView(post: self.footerCellViewModel.post)) {
                Text("View all comments")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .accentColor(.red)
            }
            
            HStack {
                URLImage(url: URL(string: footerCellViewModel.post.avatar)!, content: {
                    $0
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                })
                .frame(width: 25, height: 25)
                Text("Add a comment...")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("❤️")
                Text("👏")
                Image(systemName: "plus.circle").foregroundColor(.gray)
            }
            .padding(.trailing, 15)
            .padding(.leading, 15)
            Text("1 day ago").font(.caption).foregroundColor(.gray).padding(.leading, 15)
        }
    }
}


//
//  FooterCell.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI
import URLImage

struct FooterCell: View {
    var post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "heart.fill")
                NavigationLink(destination: CommentView()) {
                    Image(systemName: "bubble.left").renderingMode(.original)
                }
                
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark.fill")
            }
            .padding(.trailing, 15)
            .padding(.leading, 15)
            
            HStack {
                Text(post.username)
                    .font(.subheadline)
                    .bold()
                Text("Black and White")
                    .font(.subheadline)
            }
            .padding(.leading, 15)
            NavigationLink(destination: CommentView()) {
                Text("View all comments")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .accentColor(.red)
            }
            
            HStack {
                URLImage(url: URL(string: post.avatar)!, content: {
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


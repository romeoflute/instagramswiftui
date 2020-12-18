//
//  HeaderCell.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI
import URLImage

struct HeaderCell: View {
    var post: Post
    var body: some View {
        VStack {
            HStack {
                URLImage(url: URL(string: post.avatar)!, content: {
                    $0
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                })
                .frame(width: 35, height: 35)
                
                VStack(alignment: .leading) {
                    Text(post.username)
                        .font(.subheadline)
                        .bold()
                    Text("location")
                        .font(.caption)
                }
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.trailing, 15)
            .padding(.leading, 15)
            
            URLImage(url: URL(string: post.mediaUrl)!, content: {
                $0
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            })
            .frame(width: UIScreen.main.bounds.size.width, height: 300).clipped()
        }
    }
}


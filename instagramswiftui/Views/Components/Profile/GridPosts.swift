//
//  GridPosts.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/15/20.
//

import SwiftUI
import URLImage

struct GridPosts: View {
    
    var splitted: [[Post]] = []
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            // rows
            ForEach(0..<self.splitted.count) { index in
                HStack(spacing: 1) {
                    // Columns
                    ForEach(self.splitted[index], id: \.postId) { post in
                        
                        URLImage(url: URL(string: post.mediaUrl)!,
                                 content: {
                                    $0
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    
                        }).frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3).clipped()
                    }
                }
            }
        }
    }
}

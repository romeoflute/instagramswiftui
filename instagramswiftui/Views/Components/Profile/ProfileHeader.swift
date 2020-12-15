//
//  ProfileHeader.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI
import URLImage

struct ProfileHeader: View {
    var user: User?
    var body: some View {
        HStack {
            
            if user != nil {
                URLImage(url: URL(string: user!.profileImageUrl)!,
                         content: {
                            $0
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                         }).frame(width: 80, height: 80).padding(.leading, 20)
                
                
                Spacer()
                VStack {
                    Text("50").font(.headline)
                    Text("Posts").font(.subheadline)
                }.padding(10)
                VStack {
                    Text("100").font(.headline)
                    Text("Followers").font(.subheadline)
                }.padding(10)
                VStack {
                    Text("200").font(.headline)
                    Text("Following").font(.subheadline)
                }.padding(10)
                Spacer()
            }
        }
    }
}

//
//  UserProfileView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/10/20.
//

import SwiftUI

struct UserProfileView: View {
    var user: User
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var selection: Selection = .grid
    
    var body: some View {
        return
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ProfileHeader(user: user)
                    ProfileInformation(user: user)
                    HStack(spacing: 5) {
                        FollowButton()
                        MessageButton(user: user)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    
                    Picker(selection: $selection, label: Text("Grid or Table")) {
                        ForEach(Selection.allCases) { selection in
                            selection.image.tag(selection)
                            
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    
                    if !profileViewModel.isLoading {
                        if selection == .grid {
                            GridPosts(splitted: self.profileViewModel.splitted)
                        } else {
                            ForEach(self.profileViewModel.posts, id: \.postId) { post in
                                VStack {
                                    HeaderCell(post: post)
                                    FooterCell(post: post)
                                }
                            }
                        }
                    }
                    
                }
                .padding(.top, 20)
                
            }
            .navigationBarTitle(Text(self.user.username), displayMode: .inline)
            .onAppear {
                self.profileViewModel.loadUserPosts(userId: self.user.uid)
            }
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}

struct FollowButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Spacer()
                Text("Follow").fontWeight(.bold).foregroundColor(Color.white)
                Spacer()
            }.frame(height: 30).background(Color.blue)
            
        }.cornerRadius(5)
    }
}

struct MessageButton: View {
    var user: User
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Spacer()
                NavigationLink(destination: ChatView(recipientId: user.uid, recipientAvatarUrl: user.profileImageUrl, recipientUsername: user.username)) {
                    Text("Message").fontWeight(.bold).foregroundColor(Color.black)
                }
                Spacer()
            }.frame(height: 30).background(Color.white)
            
        }.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5), lineWidth: 1))
    }
}

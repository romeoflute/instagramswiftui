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
    @State var followingCountState = 0
    @State var followersCountState = 0
    
    var body: some View {
        return
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ProfileHeader(user: user, followingCount: $followingCountState, followersCount: $followersCountState)
                    ProfileInformation(user: user)
                    HStack(spacing: 5) {
                        FollowButton(user: user, followingCount: $followingCountState, followersCount: $followersCountState)

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
    
    @ObservedObject var followViewModel = FollowViewModel()

    var user: User
    @Binding var following_Count: Int
    @Binding var followers_Count: Int
    
    init(user: User, followingCount: Binding<Int>, followersCount: Binding<Int>) {
        self.user = user
        self._following_Count = followingCount
        self._followers_Count = followersCount
        updateFollowCount()
        checkFollowState()
    }
    
    func checkFollowState() {
        followViewModel.checkFollow(userId: self.user.uid)
    }
    
    func updateFollowCount() {
        followViewModel.updateFollowCount(userId: user.uid, followingCount_onSuccess: { (following_Count) in
            self.following_Count = following_Count
        }) { (followers_Count) in
            self.followers_Count = followers_Count
        }
    }

    func follow() {
        followViewModel.handleFollow(userId: user.uid, followingCount_onSuccess: { (followingCount) in
            self.following_Count = followingCount
        }) { (followersCount) in
            self.followers_Count = followersCount
        }
    }
    
    var body: some View {
        Button(action: follow) {
            HStack {
                Spacer()
                Text((followViewModel.isFollowing) ? "UnFollow" : "Follow")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .frame(height: 30)
            .background(Color.blue)
        }
        .cornerRadius(5)
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

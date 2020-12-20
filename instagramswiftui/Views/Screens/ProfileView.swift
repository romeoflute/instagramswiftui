//
//  ProfileView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var followingCountState = 0
    @State var followersCountState = 0
    @State var selection: Selection = .grid
    
    var body: some View {
        
        return
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        ProfileHeader(user: self.session.userSession, followingCount: $followingCountState, followersCount: $followersCountState)
                        EditProfileButton()
                        ProfileInformation(user: self.session.userSession)
                        
                        Picker(selection: $selection, label: Text("Grid or Table")) {
                            ForEach(Selection.allCases) { selection in
                                selection.image.tag(selection)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.leading, 20).padding(.trailing, 20)
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
                .navigationBarTitle(Text("Profile"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {}) {
                    NavigationLink(destination: UsersView()) {
                        Image(systemName: "person.fill").imageScale(Image.Scale.large).foregroundColor(.black)
                    }
                },trailing:
                    Button(action: {
                        self.session.logout()
                        
                    }) {
                        
                        Image(systemName: "arrow.right.circle.fill").imageScale(Image.Scale.large).foregroundColor(.black)
                        
                    }
                )
                .onAppear {
                    self.profileViewModel.loadUserPosts(userId: Auth.auth().currentUser!.uid)
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


//struct EditProfileButton: View {
//    var body: some View {
//        Button(action: {}) {
//            HStack {
//                Spacer()
//                Text("Edit Profile").fontWeight(.bold).foregroundColor(Color.white)
//                Spacer()
//            }.frame(height: 30).background(Color.black)
//
//        }.cornerRadius(5).padding(.leading, 20).padding(.trailing, 20)
//    }
//}
//
//struct ProfileInformation: View {
//    var user: User
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text(user.username).bold()
//            Text("IOS Developer")
//        }.padding(.leading, 20)
//    }
//}

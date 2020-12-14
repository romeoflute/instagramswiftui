//
//  ProfileView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    var photoArray = [Photo(photo: "photo"), Photo(photo: "photo1"), Photo(photo: "photo2"), Photo(photo: "photo3"), Photo(photo: "photo4"), Photo(photo: "photo5"), Photo(photo: "photo6"), Photo(photo: "photo7"),  Photo(photo: "photo8"), Photo(photo: "photo9")]
    @State var selection = 0
    var displayState = ["square.grid.2x2.fill", "list.dash"]
    var body: some View {
        let splitted = photoArray.splited(into: 3)
        return
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        ProfileHeader(user: self.session.userSession!)
                        EditProfileButton()
                        ProfileInformation(user: self.session.userSession!)
                        
                        Picker(selection: $selection, label: Text("Grid or Table")) {
                            ForEach(0..<displayState.count) { index in
                                Image(systemName: self.displayState[index]).tag(index)
                                
                            }
                        }.pickerStyle(SegmentedPickerStyle()).padding(.leading, 20).padding(.trailing, 20)
                        VStack(alignment: .leading, spacing: 1) {
                            // rows
                            ForEach(0..<splitted.count) { index in
                                HStack(spacing: 1) {
                                    // Columns
                                    ForEach(splitted[index]) { photo_element in
                                        Image(photo_element.photo).resizable().scaledToFill().frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3).clipped()
                                        
                                    }
                                }
                                
                            }
                        }
                        
                    }.padding(.top, 20)
                    
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
                        
                    } )
            }
        
        
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}



struct EditProfileButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Spacer()
                Text("Edit Profile").fontWeight(.bold).foregroundColor(Color.white)
                Spacer()
            }.frame(height: 30).background(Color.black)
            
        }.cornerRadius(5).padding(.leading, 20).padding(.trailing, 20)
    }
}

struct ProfileInformation: View {
    var user: User
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.username).bold()
            Text("IOS Developer")
        }.padding(.leading, 20)
    }
}

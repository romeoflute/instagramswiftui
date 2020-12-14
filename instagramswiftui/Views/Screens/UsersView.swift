//
//  UsersView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/10/20.
//

import SwiftUI
struct UsersView: View {
    
    @ObservedObject var usersViewModel = UsersViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $usersViewModel.searchText, onSearchButtonChanged: usersViewModel.searchTextDidChange)
            
            List {
                if !usersViewModel.isLoading {
                    
                    ForEach(usersViewModel.users, id: \.uid) { user in
                        HStack {
                            Image("photo1").resizable().clipShape(Circle()).frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(user.username)
                                    .font(.headline)
                                    .bold()
                                Text("IOS Developer")
                                    .font(.subheadline)
                            }
                            
                        }
                        .padding(10)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Search"), displayMode: .inline)
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}

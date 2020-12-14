//
//  UsersViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/14/20.
//
import SwiftUI

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    var searchText: String = ""
    
    func searchTextDidChange() {
        isLoading = true
        //Api.User.searchUsers(text: searchText)
        Api.User.searchUsers(text: searchText) { (users) in
            self.isLoading = false
            self.users = users
        }
    }
}

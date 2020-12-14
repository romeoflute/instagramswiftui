//
//  InitialView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/7/20.
//

import SwiftUI

struct InitialView: View {
    @EnvironmentObject var session: SessionStore
    func listen(){
        session.listenAuthenticationState()
    }
    var body: some View {
        Group{
            if session.isLoggedIn {
                MainView()
            }else{
                SigninView()
            }
        }
        .onAppear(perform: listen)
    }
}



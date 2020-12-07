//
//  MainView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/7/20.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: SessionStore
    func logout(){
        session.logout()
    }
    
    var body: some View {
        Group {
            Text((session.userSession == nil) ? "Loading..." : session.userSession!.email)
            Button(action:logout, label: {
                Text("Log out")
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

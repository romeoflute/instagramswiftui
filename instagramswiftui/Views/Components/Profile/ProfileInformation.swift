//
//  ProfileInformation.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/15/20.
//

import SwiftUI

struct ProfileInformation: View {
    var user: User?
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            if user != nil {
                Text(user!.username).bold()
                Text("IOS Developer")
            }
            
        }.padding(.leading, 20)
    }
}



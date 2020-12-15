//
//  EditProfileButton.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/15/20.
//

import SwiftUI

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


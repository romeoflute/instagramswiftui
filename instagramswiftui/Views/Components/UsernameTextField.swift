//
//  UsernameTextField.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/5/20.
//

import SwiftUI

struct UsernameTextField: View {
    @Binding var username: String
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .foregroundColor(COLOR_LIGHT_GRAY)
            
            TextField(TEXT_USERNAME, text: $username)
        }
        .modifier(TextFieldModifier())
    }
}

struct UsernameTextField_Previews: PreviewProvider {
    static var previews: some View {
        UsernameTextField(username: .constant("Kelogz"))
    }
}

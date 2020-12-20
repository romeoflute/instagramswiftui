//
//  PasswordTextField.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var password:String
    var body: some View {
        HStack{
            Image(systemName: "lock.fill")
                .foregroundColor(COLOR_LIGHT_GRAY)
            
            SecureField(TEXT_PASSWORD, text: $password)
        }
        .modifier(TextFieldModifier())
    }
}

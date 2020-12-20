//
//  EmailTextField.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String
    
    var body: some View {
        HStack{
            Image(systemName: "envelope.fill")
                .foregroundColor(COLOR_LIGHT_GRAY)
            
            TextField(TEXT_EMAIL, text: $email)
        }
        .modifier(TextFieldModifier())
    }
}

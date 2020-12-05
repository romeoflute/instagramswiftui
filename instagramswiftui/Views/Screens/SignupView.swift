//
//  SignupView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/5/20.
//

import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    var body: some View {
        VStack{
            Image(IMAGE_USER_PLACEHOLDER)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding()
            UsernameTextField(username: $username)
            EmailTextField(email: $email)
            VStack(alignment:.leading) {
                PasswordTextField(password: $password)
                Text(TEXT_SIGNUP_PASSWORD_REQUIRED)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
            SignupButton(action: {
                
            }, label: TEXT_SIGN_UP)
            Divider()
            Text(TEXT_SIGNUP_NOTE)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

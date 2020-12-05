//
//  ContentView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct SigninView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                HeaderView()
                Divider()
                EmailTextField(email: $email)
                PasswordTextField(password: $password)
                SigninButton(action: {}, label: "Sign in")
                Divider()
                HStack{
                    Text(TEXT_NEED_AN_ACCOUNT)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    NavigationLink(destination: SignupView()) {
                        Text(TEXT_SIGN_UP)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
        }
        .accentColor(.black)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}





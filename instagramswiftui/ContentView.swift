//
//  ContentView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack{
            Spacer()
            HeaderView()
            Spacer()
            Divider()
            EmailTextField(email: $email)
            PasswordTextField(password: $password)
            SigninButton(action: {}, label: "Sign in")
            Divider()
            SignupView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





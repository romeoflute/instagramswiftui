//
//  ContentView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct SigninView: View {
    
    @ObservedObject var signinViewModel = SigninViewModel()
    
    func signIn() {
        signinViewModel.signin(email: signinViewModel.email, password: signinViewModel.password, completed: { (user) in
            print("login complete: ", user.email)
            self.clean()
            // Switch to the Main App
        }) { (errorMessage) in
            print("Error: \(errorMessage)")
            self.signinViewModel.showAlert = true
            self.signinViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func clean() {
        self.signinViewModel.email = ""
        self.signinViewModel.password = ""
    }
    
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                HeaderView()
                Divider()
                EmailTextField(email: $signinViewModel.email)
                PasswordTextField(password: $signinViewModel.password)
                
                SigninButton(action: signIn, label: TEXT_SIGN_IN)
                    .alert(isPresented: $signinViewModel.showAlert) {
                        Alert(title: Text("Error"), message: Text(self.signinViewModel.errorString), dismissButton: .default(Text("OK")))
                    }
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





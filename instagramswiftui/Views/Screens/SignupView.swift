//
//  SignupView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/5/20.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignupView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showImagePicker:Bool = false
    
    @State private var image: Image = Image(IMAGE_USER_PLACEHOLDER)
    @State private var imageData: Data = Data()
    let mv = SignupViewModel()
    
    func signup(){
        mv.signup(username: username, email: email, password: password, imageData: imageData) { (user) in
            
        } onError: { (errorMessage) in
            print("There was an error while registering the user: \(errorMessage)")
        }
    }
    
    
    var body: some View {
        VStack{
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding()
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    showImagePicker = true
                })
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
                signup()
            }, label: TEXT_SIGN_UP)
            Divider()
            Text(TEXT_SIGNUP_NOTE)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
        }
        .navigationBarTitle("Register", displayMode: .inline)
        .sheet(isPresented: $showImagePicker){
            ImagePicker(showImagePicker: self.$showImagePicker, pickedImage: self.$image, imageData: self.$imageData)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

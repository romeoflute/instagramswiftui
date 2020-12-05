//
//  SignupButton.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/5/20.
//

import SwiftUI

struct SignupButton: View {
    var action: () -> Void
    var label: String
    var body: some View {
        Button(action: action) {
            Spacer()
            Text(label)
                .bold()
                .foregroundColor(.white)
            Spacer()
        }
        .modifier(SigninButtonModifier())
    }
}

struct SignupButton_Previews: PreviewProvider {
    static var previews: some View {
        SignupButton(action: {
            
        }, label: TEXT_SIGN_UP)
    }
}

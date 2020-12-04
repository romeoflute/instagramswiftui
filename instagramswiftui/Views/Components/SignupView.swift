//
//  SignupView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct SignupView: View {
    var body: some View {
        HStack{
            Text(TEXT_NEED_AN_ACCOUNT)
                .font(.footnote)
                .foregroundColor(.gray)
            Button(action: {
                
            }) {
                Text(TEXT_SIGN_UP)
                    .foregroundColor(.black)
            }
        }
    }
}


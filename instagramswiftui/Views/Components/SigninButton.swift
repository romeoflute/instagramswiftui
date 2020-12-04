//
//  SigninButton.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct SigninButton: View {
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

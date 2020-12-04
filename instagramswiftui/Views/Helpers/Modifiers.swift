//
//  Modifiers.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .border(COLOR_LIGHT_GRAY, width: 1)
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
        
    }
}

struct SigninButtonModifier:ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.black)
            .cornerRadius(5)
            .shadow(color: .gray, radius: 10, x: 0, y: 10)
            .padding()
    }
}

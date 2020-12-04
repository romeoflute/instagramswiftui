//
//  HeaderView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Group{
            Image(IMAGE_LOGO)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
            Text(TEXT_SIGNIN_HEADLINE)
                .font(.title)
                .padding(.bottom)
            Text(TEXT_SIGNIN_SUBHEADLINE)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }
}

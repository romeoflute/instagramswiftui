//
//  CameraView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct CameraView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Image("photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                    TextField("Write a caption...", text: .constant(""))
                        .padding(.top, 5)
               }
                .padding()
                
                Spacer()
                
            }
            .navigationBarTitle(Text("Camera"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "arrow.turn.up.right")
                    .imageScale(Image.Scale.large)
            })
            .foregroundColor(.black)
        }
        
       
    }
}
struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}

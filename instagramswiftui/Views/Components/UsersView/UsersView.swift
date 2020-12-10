//
//  UsersView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/10/20.
//

import SwiftUI

struct UsersView: View {
    
    var body: some View {
        NavigationView{
                List {
                        ForEach(0..<10) { _ in
                                HStack {
                                Image("photo1").resizable().clipShape(Circle()).frame(width: 50, height: 50)
                                        
                                    VStack(alignment: .leading, spacing: 5) {
                                     Text("David").font(.headline).bold()
                                        Text("IOS Developer").font(.subheadline)
                                    }
                                  
                                }.padding(10)
                       }
               
               
                }
            .navigationBarTitle(Text("Search"), displayMode: .inline)
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}

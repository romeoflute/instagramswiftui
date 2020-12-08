//
//  HomeView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            List{
                Story()
                
                ForEach(1..<10){ i in
                    Text("Post")
                }
            }
        }
        .navigationBarTitle("Instagram")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  HomeView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
           ScrollView {
               Story()
               
//               ForEach(1..<20) { _ in
//                   VStack {
//                         HeaderCell()
//                         FooterCell()
//                   }
//               }
           }.navigationBarTitle(Text("Instagram"), displayMode: .inline)
       }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


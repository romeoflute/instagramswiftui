//
//  HomeView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Story()
                if !homeViewModel.isLoading {
                    ForEach(self.homeViewModel.posts, id: \.postId) { post in
                        VStack {
                            HeaderCell(post: post)
                            FooterCell(post: post)
                        }
                    }
                }
                
            }
            .navigationBarTitle(Text("Instagram"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {}) {
                    NavigationLink(destination: MessagesView()) {
                        Image(systemName: "paperplane.fill").imageScale(Image.Scale.large).foregroundColor(.black)
                    }
                }
            )
            .onAppear {
                self.homeViewModel.loadTimeline()
            }
            .onDisappear {
                self.homeViewModel.listener.remove()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


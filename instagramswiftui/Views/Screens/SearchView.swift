//
//  SearchView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var postPopularViewModel = PostPopularViewModel()
    @State var selection: Selection = .grid
    var body: some View {
        return
            NavigationView {
                ScrollView {
                        
                        Picker(selection: $selection, label: Text("Grid or Table")) {
                        ForEach(Selection.allCases) { selection in
                                selection.image.tag(selection)
                                        
                            }
                        }.pickerStyle(SegmentedPickerStyle()).padding()
                        if !postPopularViewModel.isLoading {
                              if selection == .grid {
                                  GridPosts(splitted: self.postPopularViewModel.splitted)
                              } else {
                                  ForEach(self.postPopularViewModel.posts, id: \.postId) { post in
                                      VStack {
                                          HeaderCell(post: post)
                                          FooterCell(post: post)
                                      }
                                  }
                                 
                              }
                          
                        }
               
                    }.navigationBarTitle(Text("Discover"), displayMode: .inline).onAppear {
                        self.postPopularViewModel.loadPostPopular()
                    }
            }
    
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

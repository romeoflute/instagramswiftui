//
//  SearchBar.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var onSearchButtonChanged: (() -> Void)? = nil
    
    class Coordinator: NSObject, UISearchBarDelegate {
        let searchBarView: SearchBar
        
        init(_ searchBar: SearchBar) {
            self.searchBarView = searchBar
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchBarView.text = searchText
            searchBarView.onSearchButtonChanged?()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.delegate = context.coordinator
        
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = self.text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

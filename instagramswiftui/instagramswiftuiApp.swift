//
//  instagramswiftuiApp.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/4/20.
//

import SwiftUI
import Firebase
//https://www.youtube.com/watch?v=Yci15SmN9j4&list=UUBo6NP6WdlePYlJMLKLK40g

@main
struct instagramswiftuiApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            SigninView()
        }
    }
}

//
//  ChatView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/14/20.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatViewModel = ChatViewModel()
    
    var recipientId = ""
    var recipientAvatarUrl = ""
    var recipientUsername = ""
    
    func sendTextMessage() {        
        chatViewModel.sendTextMessage(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, completed: {
            self.clean()
        }) { (errorMessage) in
            self.chatViewModel.showAlert = true
            self.chatViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func sendPhoto() {
        chatViewModel.sendPhotoMessage(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, completed: {
            
        }) { (errorMessage) in
            self.chatViewModel.showAlert = true
            self.chatViewModel.errorString = errorMessage
        }
    }
    
    func showPicker() {
        self.chatViewModel.showImagePicker = true
    }
    
    func clean() {
        self.chatViewModel.composedMessage = ""
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading) {
                        ChatRow(isCurrentUser: false)
                        ChatRow(isCurrentUser: true)
                        ChatRow(isCurrentUser: false, isPhoto: true)
                    }.padding(.top, 20)
                }
            }
            HStack(spacing: 0) {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1).padding()
                    
                    HStack(spacing: 10) {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1).padding()
                            
                            HStack(spacing: 10) {
                                Button(action: {}) {
                                    Image(systemName: "camera.fill")
                                        .padding(12)
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                }
                                .padding(.leading, 20)
                                
                                TextField("Message...", text: $chatViewModel.composedMessage)
                                    .padding(.top, 30)
                                    .padding(.bottom, 30)
                                Button(action: showPicker) {
                                    Image(systemName: "photo").imageScale(.large).foregroundColor(.black)
                                }
                                Button(action: {}) {
                                    Image(systemName: "mic.fill")
                                        .imageScale(.large)
                                        .foregroundColor(.black)
                                }
                                Button(action: sendTextMessage) {
                                    Image(systemName: "paperplane")
                                        .imageScale(.large)
                                        .foregroundColor(.black)
                                        .padding(.trailing, 30)
                                }
                                
                            }
                            .frame(height: 60)
                        }
                        
                    }
                    .frame(height: 60)
                }
            }
            .sheet(isPresented: $chatViewModel.showImagePicker, onDismiss: {
                self.sendPhoto()
            }) {
               // ImagePickerController()
                ImagePicker(showImagePicker: self.$chatViewModel.showImagePicker, pickedImage: self.$chatViewModel.image, imageData: self.$chatViewModel.imageData)
            }.navigationBarTitle(Text("Chat"), displayMode: .inline).alert(isPresented: $chatViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.chatViewModel.errorString), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView()
        }
    }
    
    struct ChatRow: View {
        var isCurrentUser = false
        var isPhoto = false
        var body: some View {
            Group {
                if !isCurrentUser && !isPhoto {
                    HStack(alignment: .top) {
                        Image("photo").resizable().scaledToFill().frame(width: 30, height: 30).clipShape(Circle())
                        Text("Hi guys  ").padding(10).foregroundColor(.black).background(Color(red: 237/255, green: 237/255, blue: 237/255)).cornerRadius(10).font(.callout)
                    }.padding(.leading, 15).padding(.trailing, 50)
                } else if !isPhoto{
                    HStack(alignment: .top) {
                        Spacer(minLength: 50)
                        Text("Hi guys  ").padding(10).foregroundColor(.white).background(Color.blue).cornerRadius(10).font(.callout)
                    }.padding(.trailing, 15)
                }
                
                if !isCurrentUser && isPhoto {
                    HStack(alignment: .top) {
                        Image("photo").resizable().scaledToFill().frame(width: 30, height: 30).clipShape(Circle())
                        Image("photo1").scaledToFill().frame(width: 200, height: 200).cornerRadius(10)
                        Spacer()
                    }.padding(.leading, 15)
                    
                } else if isCurrentUser && isPhoto {
                    HStack {
                        Spacer()
                        Image("photo6").scaledToFill().frame(width: 200, height: 200).cornerRadius(10)
                    }.padding(.trailing, 15)
                    
                }
            }
        }
    }
}

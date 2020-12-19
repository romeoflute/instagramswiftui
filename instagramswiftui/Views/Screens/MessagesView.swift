//
//  MessagesView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/14/20.
//

import SwiftUI
import URLImage

struct MessagesView: View {
    @ObservedObject var messageViewModel = MessageViewModel()
    
    var body: some View {
        List {
            if !messageViewModel.inboxMessages.isEmpty {
                ForEach(messageViewModel.inboxMessages, id: \.id) { inboxMessage in
                    NavigationLink(destination: ChatView(recipientId: inboxMessage.userId, recipientAvatarUrl: inboxMessage.avatarUrl, recipientUsername: inboxMessage.username)) {
                        HStack {
                            URLImage(url: URL(string: inboxMessage.avatarUrl)!, content: {
                                $0
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                            })
                            .frame(width: 50, height: 50)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(inboxMessage.username)
                                    .font(.headline).bold()
                                Text(inboxMessage.lastMessage)
                                    .font(.subheadline).lineLimit(2)
                            }
                            Spacer()
                            VStack(spacing: 5) {
                                Text(timeAgoSinceDate(Date(timeIntervalSince1970: inboxMessage.date), currentDate: Date(), numericDates: true))
                                    .bold()
                                    .padding(.leading, 15)
                            }
                            
                        }
                        .padding(10)
                    }
                }
            }
            
        }.navigationBarTitle(Text("Messages"), displayMode: .inline)
        .onDisappear {
            if self.messageViewModel.listener != nil {
                self.messageViewModel.listener.remove()
            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}

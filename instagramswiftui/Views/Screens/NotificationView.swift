//
//  NotificationView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI
import URLImage

struct NotificationView: View {
    @ObservedObject var activityViewModel = ActivityViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if !activityViewModel.activityArray.isEmpty {
                    ForEach(self.activityViewModel.activityArray, id: \.activityId) { activity in
                          HStack {
                            URLImage(url: URL(string: activity.userAvatar)!,
                                                         content: {
                                                             $0
                                                                 .resizable()
                                                                 .aspectRatio(contentMode: .fill)
                                                                 .clipShape(Circle())
                                                         }).frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(activity.username)
                                    .font(.subheadline)
                                    .bold()
                                Text(activity.typeDescription)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true))
                                .font(.caption)
                                .foregroundColor(.gray)

                        }
                          .padding(10)
                    }
                }
            }.navigationBarTitle(Text("Activity"), displayMode: .inline).onAppear {
                  self.activityViewModel.loadActivities()
             }
            .onDisappear {
                 if self.activityViewModel.listener != nil {
                     self.activityViewModel.listener.remove()

                 }
              }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

//
//  CommentRow.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct CommentRow: View {
    var body: some View {
        HStack {
             Image("photo1").resizable().clipShape(Circle())
                 .frame(width: 35, height: 35)
             VStack(alignment: .leading) {
                Text("David")
                    .font(.subheadline)
                    .bold()
                 Text("Comment")
                    .font(.caption)
             }
             Spacer()
             Text("1 day ago")
                .font(.caption)
                .foregroundColor(.gray)
         }
        .padding(.trailing, 15)
        .padding(.leading, 15)
    }
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow()
    }
}


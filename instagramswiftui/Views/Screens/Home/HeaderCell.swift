//
//  HeaderCell.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct HeaderCell: View {
    var body: some View {
        VStack {
            HStack {
                    Image("photo1").resizable().clipShape(Circle())
                        .frame(width: 35, height: 35)
                    VStack(alignment: .leading) {
                        Text("David").font(.subheadline).bold()
                        Text("location").font(.caption)
                    }
                    Spacer()
                Image(systemName: "ellipsis")
                }.padding(.trailing, 15).padding(.leading, 15)
                
            Image("photo2").resizable().scaledToFill().frame(width: UIScreen.main.bounds.size.width, height: 300).clipped()
        }
    
    }
}

struct HeaderCell_Previews: PreviewProvider {
    static var previews: some View {
        HeaderCell()
    }
}

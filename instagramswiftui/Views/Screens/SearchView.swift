//
//  SearchView.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/8/20.
//

import SwiftUI

struct Photo: Identifiable {
    let id = UUID()
    var photo = ""
}


struct SearchView: View {
    var photoArray = [Photo(photo: "photo"), Photo(photo: "photo1"), Photo(photo: "photo2"), Photo(photo: "photo3"), Photo(photo: "photo4"), Photo(photo: "photo5"), Photo(photo: "photo6"), Photo(photo: "photo7"),  Photo(photo: "photo8"), Photo(photo: "photo9")]
    @State var selection = 0
    var displayState = ["square.grid.2x2.fill", "list.dash"]
    var body: some View {
        let splitted = photoArray.splited(into: 3)
        return
            NavigationView {
                ScrollView {
                            
                        Picker(selection: $selection, label: Text("Grid or Table")) {
                            ForEach(0..<displayState.count) { index in
                                Image(systemName: self.displayState[index]).tag(index)
                                
                            }
                            }.pickerStyle(SegmentedPickerStyle()).padding()
                            // rows
                               ForEach(0..<splitted.count) { index in
                                   HStack(spacing: 1) {
                                       // Columns
                                       ForEach(splitted[index]) { photo_element in
                                           Image(photo_element.photo).resizable().scaledToFill().frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3).clipped()
                                           
                                       }
                                   }
                                   
                               }
               
                    }.navigationBarTitle(Text("Discover"), displayMode: .inline)
            }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

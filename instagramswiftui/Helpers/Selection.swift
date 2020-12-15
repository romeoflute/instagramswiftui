//
//  Selection.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/15/20.
//

import Foundation
import SwiftUI

enum Selection: Int, CaseIterable, Identifiable {
    case grid
    case table
    
    var id: UUID {
        return UUID()
    }
    
    var image: Image {
        switch self {
        case .grid:
            return Image(systemName: "square.grid.2x2.fill")
        case .table:
            return Image(systemName: "list.dash")
        }
    }
}


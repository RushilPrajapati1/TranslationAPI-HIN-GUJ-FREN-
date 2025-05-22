//
//  Item.swift
//  Translation APP
//
//  Created by Rushil Prajapati on 5/22/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

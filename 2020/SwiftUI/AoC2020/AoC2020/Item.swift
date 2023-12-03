//
//  Item.swift
//  AoC2020
//
//  Created by Martin Linklater on 02/12/2023.
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

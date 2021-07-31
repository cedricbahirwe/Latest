//
//  AlertModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 31/07/2021.
//

import Foundation

struct AlertModel: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var body: String
    let type: String = "default"
    let duration: Double = 3.0 // Time to be displayed in seconds
    
}

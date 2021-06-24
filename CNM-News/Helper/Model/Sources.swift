//
//  Sources.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/24/21.
//

import Foundation

struct Sources: Codable {
    let sources: [SourceNews]
}

struct SourceNews:Codable {
    let id : String
    let name: String
    let description: String
}

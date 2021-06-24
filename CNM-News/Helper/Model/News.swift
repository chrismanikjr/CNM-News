//
//  News.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/23/21.
//

import Foundation

struct News: Codable {
    let articles: [Articles]
    
}
struct Articles: Codable{
//    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String

}



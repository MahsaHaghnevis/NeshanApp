//
//  SearrchResponseModel.swift
//  Map
//
//  Created by Mahsa on 9/11/24.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let items: [SearchResult]
}

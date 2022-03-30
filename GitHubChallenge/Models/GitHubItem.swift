//
//  GitHubItem.swift
//  GitHubChallenge
//
//  Created by Kaique Alves on 29/03/22.
//  Copyright © 2022 Kaique Alves. All rights reserved.
//

import Foundation

extension GitHub {
    
    struct Item: Codable {
        var name: String
        var fullName: String
        var owner: Owner
        var totalStars: Int
        
        enum CodingKeys: String, CodingKey {
            case name
            case fullName = "full_name"
            case owner
            case totalStars = "stargazers_count"
        }
    }
}

//
//  GitHubItemOwner.swift
//  GitHubChallenge
//
//  Created by Kaique Alves on 29/03/22.
//  Copyright © 2022 Kaique Alves. All rights reserved.
//

import Foundation

extension GitHub.Item {
    
    struct Owner: Codable {
        let avatarURL: URL
        let repositoryURL: URL
        
        enum CodingKeys: String, CodingKey {
            case avatarURL = "avatar_url"
            case repositoryURL = "html_url"
        }
    }
}

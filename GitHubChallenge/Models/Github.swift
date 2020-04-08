//
//  Github.swift
//  GitHubChallenge
//
//  Created by Kaique Alves on 21/03/20.
//  Copyright © 2020 Kaique Alves. All rights reserved.
//

import Foundation

struct Github: Codable{
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [Item]?

    struct Item: Codable{
        var name: String?
        var full_name: String?
        var owner: Owner?
        var stargazers_count: Int?


        struct Owner: Codable{
            var avatar_url: String?
        }
    }
}

/*
struct License: Codable{
    var key: String?
    var name: String?
    var spdx_id: String?
    var url: String?
    var node_id: String?
}
*/

//
//  RepositoryModel.swift
//  TestGitApi
//
//  Created by Alex on 31/07/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

struct RepositoryModel: Codable {
    let description: String?
    let homepage: String?
    let full_name: String
    let forks_count: Int
    var readmeFileContents: String?
}

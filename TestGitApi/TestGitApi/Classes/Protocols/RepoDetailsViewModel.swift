//
//  RepoDetailsViewModel.swift
//  TestGitApi
//
//  Created by Alex on 01/08/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

protocol RepoDetailsViewModel {
    typealias successBlock = (_ repositoryReadme: String) -> Void
    typealias failBlock = (_ errorString: String) -> Void
    
    func getRepoReadme (completion: @escaping successBlock, fail: @escaping failBlock)
    static func initWithRepository (_ repository: RepositoryModel) -> RepoDetailsViewModel?
}

//
//  RepositoryDetailsViewModel.swift
//  TestGitApi
//
//  Created by Alex on 01/08/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
class RepositoryDetailsViewModel {
    var repoModel: RepositoryModel!
    
    init (repository: RepositoryModel) {
        self.repoModel = repository
    }
}

extension RepositoryDetailsViewModel: RepoDetailsViewModel {
    func getRepoReadme(completion: @escaping successBlock, fail: @escaping failBlock) {
        APIRequestManager.sharedInstance.requestReadmeForRepository(repoFullName: repoModel.full_name, success: { (readmeString) in
            completion(readmeString)
        }, failure: { (errorString) in
            fail(errorString)
        })
    }
    
    static func initWithRepository(_ repository: RepositoryModel) -> RepoDetailsViewModel? {
        return RepositoryDetailsViewModel(repository: repository)
    }
    
    
}

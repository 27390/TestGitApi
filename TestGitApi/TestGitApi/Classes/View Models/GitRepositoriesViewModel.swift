//
//  GitRepositoriesViewModel.swift
//  TestGitApi
//
//  Created by Alex on 31/07/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
class GitRepositoriesViewModel {
    
   
    
    var repositories = [RepositoryModel]()
    
    public func searchDataWithQuery (_ query: String, error: querryFailCompletion) {
        APIRequestManager.sharedInstance.requestRepositoryList(searchQuery: query, success: {[weak self] (response) in
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: [])
                self?.repositories = try JSONDecoder().decode([RepositoryModel].self, from: data)
                
            } catch { print(error) }
        }) { (dict) in
            print ("in error \(dict)")
        }
    }
}

extension GitRepositoriesViewModel: GitRepositoryViewModel {
    
    func createRepositoryDetailsModelForIndex(_ index: Int) -> RepoDetailsViewModel? {
        if (index < repositories.count) {
            return RepositoryDetailsViewModel.initWithRepository(repositories[index])
        }
        return nil
    }
    
    func searchDataWithQuery(_ query: String, success: @escaping () -> Void, errorBlock: @escaping(String) -> Void) {
        guard !query.isEmpty else {
            self.repositories = []
            success()
            return
        }
        APIRequestManager.sharedInstance.requestRepositoryList(searchQuery: query, success: {[weak self] (response) in
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: [])
                self?.repositories = try JSONDecoder().decode([RepositoryModel].self, from: data)
                success()
            } catch {
                print(error)
                errorBlock("could not parse response")
            }
        }) { (errorString) in
            errorBlock(errorString)
        }
    }
    
    func getCellModelForIndex(_ index: Int) -> RepoCellViewModel {
        if (index < repositories.count) {
            return RepoCellViewModel(repository: repositories[index])
        }
        return RepoCellViewModel(string: "Unknown")
    }
    
    func getNumberOfItems() -> Int {
        return repositories.count
    }
    
    
}

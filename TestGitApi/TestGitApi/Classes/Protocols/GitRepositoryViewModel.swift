//
//  GitRepositoryViewModel.swift
//  TestGitApi
//
//  Created by Alex on 01/08/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
protocol GitRepositoryViewModel {
    typealias querryFailCompletion = (_ error: String) -> Void
    typealias querrySuccessCompletion = () -> Void
    
    func searchDataWithQuery (_ query: String, success: @escaping querrySuccessCompletion, errorBlock: @escaping querryFailCompletion)
    func getCellModelForIndex (_ index: Int) -> RepoCellViewModel
    func getNumberOfItems () -> Int
    func createRepositoryDetailsModelForIndex (_ index: Int) -> RepoDetailsViewModel?
}

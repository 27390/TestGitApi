//
//  RepoCellViewModel.swift
//  TestGitApi
//
//  Created by Alex on 01/08/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
struct RepoCellViewModel {
    let stringToShow: String
    
    init (repository: RepositoryModel){
        stringToShow = repository.description ?? "No description"
    }
    
    init (string: String){
        stringToShow = string
    }
}

//
//  RepoDetailsViewController.swift
//  TestGitApi
//
//  Created by Alex on 01/08/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {
    
    @IBOutlet weak var readmeTextView: UITextView!
    
    var repoDetailsModel: RepoDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        repoDetailsModel?.getRepoReadme(completion: { (readmeString) in
            print(readmeString)
            self.readmeTextView.text = readmeString
        }, fail: { (errorString) in
            print(errorString)
        })
    }

}

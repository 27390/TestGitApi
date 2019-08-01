//
//  GitSearchViewController.swift
//  TestGitApi
//
//  Created by Alex on 30/07/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class GitSearchViewController: UIViewController {
    
    @IBOutlet weak var gitSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let gitRepoViewModel: GitRepositoryViewModel = GitRepositoriesViewModel()
    private let segueGetDetailsName = "segueGetDetails"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let repoDetailsViewController = segue.destination as? RepoDetailsViewController, let index = sender as? Int {
            repoDetailsViewController.repoDetailsModel = gitRepoViewModel.createRepositoryDetailsModelForIndex(index)
        }
    }
    
    @objc func makeDataRequest() {
        print("searching for: \(String(describing: gitSearchBar.text))")
        gitRepoViewModel.searchDataWithQuery(gitSearchBar.text ?? "", success: {
            self.tableView.reloadData()
        }) { (errorString) in
            print("error")
        }
    }
}

//MARK: UISearchBarDelegate
extension GitSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(makeDataRequest), object: nil)
        self.perform(#selector(makeDataRequest), with: nil, afterDelay: 0.5)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: UITableViewDatasource
extension GitSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitRepoViewModel.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier, for: indexPath) as? RepoCell else {
            return RepoCell()
        }
        let cellViewModel = gitRepoViewModel.getCellModelForIndex(indexPath.row)
        cell.config(cellViewModel: cellViewModel)
        return cell
    }
}

//MARK: UITableViewDelegate
extension GitSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueGetDetailsName, sender: indexPath.row)
    }
}




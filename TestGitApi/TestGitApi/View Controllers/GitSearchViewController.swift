//
//  GitSearchViewController.swift
//  TestGitApi
//
//  Created by Alex on 30/07/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class GitSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let gitRepoViewModel: GitRepositoryViewModel = GitRepositoriesViewModel()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search repos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // to limit network activity, reload half a second after last key press.
       
    }
    
    @objc func makeDataRequest() {
        print("searching for: \(String(describing: searchController.searchBar.text))")
        gitRepoViewModel.searchDataWithQuery(searchController.searchBar.text ?? "", success: {
            self.tableView.reloadData()
        }) { (errorString) in
            print("error")
        }
    }
}

//MARK: UISearchResultsUpdating
extension GitSearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(makeDataRequest), object: nil)
        self.perform(#selector(makeDataRequest), with: nil, afterDelay: 0.5)
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
    
}




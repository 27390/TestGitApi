//
//  RepoCell.swift
//  TestGitApi
//
//  Created by Alex on 31/07/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    
    static let reuseIdentifier = "repoCell"
    
    @IBOutlet weak var mainLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(cellViewModel: RepoCellViewModel){
        self.mainLbl.text = cellViewModel.stringToShow
    }
}

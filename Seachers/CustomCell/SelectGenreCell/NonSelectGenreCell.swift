//
//  nonSelectGenreCell.swift
//  Seachers
//
//  Created by 山口誠士 on 2022/01/22.
//

import UIKit

class NonSelectGenreCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let goumandVC = GourmandSearchViewController()
        // Configure the view for the selected state
    }
    
}

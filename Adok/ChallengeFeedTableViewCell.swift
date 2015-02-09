//
//  ChallengeFeedTableViewCell.swift
//  Adok
//
//  Created by Remi Robert on 09/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ChallengeFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

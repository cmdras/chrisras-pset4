//
//  TaskCellTableViewCell.swift
//  chrisras-pset4
//
//  Created by Christopher Ras on 24/11/2016.
//  Copyright © 2016 Chris Ras. All rights reserved.
//

import UIKit

class TaskCellTableViewCell: UITableViewCell {
    @IBOutlet weak var taskLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

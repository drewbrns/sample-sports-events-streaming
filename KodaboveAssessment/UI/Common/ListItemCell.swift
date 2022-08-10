//
//  ListItemCell.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 10/08/2022.
//

import UIKit

class ListItemCell: UITableViewCell {

    static let cellId = "ListItemCell"

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemSubTitleLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

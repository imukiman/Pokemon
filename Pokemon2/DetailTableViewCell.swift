//
//  DetailTableViewCell.swift
//  Pokemon2
//
//  Created by MacOne-YJ4KBJ on 3/11/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var textFD: UITextView!
    @IBOutlet weak var lbl2D: UILabel!
    @IBOutlet weak var lbl1D: UILabel!
    @IBOutlet weak var imgD: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

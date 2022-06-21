//
//  ImageListingTableCell.swift
//  AssignmentTask
//
//  Created by SAIKAT GHOSH on 21/06/22.
//

import UIKit

class ImageListingTableCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    
}

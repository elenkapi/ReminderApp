//
//  DirectoryCell.swift
//  Elene_Kapanadze_25
//
//  Created by Ellen_Kapii on 24.08.22.
//

import UIKit

class DirectoryCell: UITableViewCell {

    
    
    @IBOutlet weak var directoryName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

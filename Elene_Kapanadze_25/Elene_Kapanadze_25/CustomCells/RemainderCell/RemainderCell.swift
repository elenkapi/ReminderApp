//
//  RemainderCell.swift
//  Elene_Kapanadze_25
//
//  Created by Ellen_Kapii on 24.08.22.
//

import UIKit

class RemainderCell: UITableViewCell {
    
    
    @IBOutlet weak var remainderTitle: UILabel!
    @IBOutlet weak var remainderBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    //MARK: - Private funcs
    
    private func designCell() {
        
        // remainder title
        //remainderTitle.textColor = .black
        
    }
    
    
    
}

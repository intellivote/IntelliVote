//
//  CandidateCell.swift
//  IntelliVote
//
//  Created by Dean Pektas on 5/24/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit

class CandidateCell: UITableViewCell {
    
    @IBOutlet weak var candidatePhoto: UIImageView!
    @IBOutlet weak var candidateName: UILabel!
    @IBOutlet weak var candidateParty: UILabel!
    @IBOutlet weak var candidateOffice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

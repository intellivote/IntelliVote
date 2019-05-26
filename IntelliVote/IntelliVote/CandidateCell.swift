//
//  CandidateCell.swift
//  IntelliVote
//
//  Created by Mohanad Osman on 5/24/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit

class CandidateCell: UITableViewCell {
    /*Image outlet for candidate Photo*/
    @IBOutlet weak var candidatePhoto: UIImageView!
    /*Label outlet for Candidate Name Label */
    @IBOutlet weak var candidateName: UILabel!
    /*Candidate Party Label outlet */
    @IBOutlet weak var candidateParty: UILabel!
    /*Candidate Office Label outlet */
    @IBOutlet weak var candidateOffice: UILabel!
    
    /*Awakes the app */
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /*This function sets the selected cell */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

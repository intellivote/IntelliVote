//
//  CandidateCollectionViewCell.swift
//  IntelliVote
//
//  Created by Yaniv Bronshtein on 5/23/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit

class CandidateCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var candidatePhoto: UIImageView!
    
    @IBOutlet weak var candidateName: UILabel!
    
    @IBOutlet weak var candidateParty: UILabel!
}

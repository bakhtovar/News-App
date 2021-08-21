//
//  SourcesCell.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 25/06/21.
//

import UIKit

class SourcesCell: UICollectionViewCell {

    @IBOutlet weak var sourceTitleLabel: UILabel!
    @IBOutlet weak var categoryTittleLabel: UILabel!
    @IBOutlet weak var rombCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        rombCell.layer.cornerRadius = 9

    }

}

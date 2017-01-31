//
//  TripleCell.swift
//  Wakarimashita
//
//  Created by Jonathan Clarke on 31/01/2017.
//  Copyright © 2017 Jonathan Clarke. All rights reserved.
//

import UIKit

class TripleCell: UITableViewCell {

    @IBOutlet weak var lblKanji: UILabel!
    @IBOutlet weak var lblHiragana: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
    
    class func getReuseIdentifier() -> String {
        return "TripleCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display( triplet : Triplet ) {
        lblKanji.text = triplet.kanji
        lblHiragana.text = triplet.hiragana
        lblEnglish.text = triplet.english

        self.backgroundColor = triplet.isRevise() ? UIColor.yellow : UIColor.white
    }
    
}

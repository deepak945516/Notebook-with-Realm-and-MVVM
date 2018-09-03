//
//  TaskTableViewCell.swift
//  RealmTest
//
//  Created by Deepak Kumar on 30/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var cellBackView: UIView!
    @IBOutlet weak var noteTitleLabel: UILabel!

    // MARK: - Life Cycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: - Private Method
    private func initialSetup() {
        cellBackView.dropShadow(shadowRadius: 5)
    }
    
}

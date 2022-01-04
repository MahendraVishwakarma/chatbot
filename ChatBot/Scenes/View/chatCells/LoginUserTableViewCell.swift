//
//  LoginUserTableViewCell.swift
//  ChatBot
//
//  Created by Mahendra Vishwakarma on 04/01/22.
//

import UIKit

class LoginUserTableViewCell: UITableViewCell {

    @IBOutlet weak var backviewContainer: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backviewContainer.layer.cornerRadius = 10
        backviewContainer.layer.masksToBounds = true
        backviewContainer.layer.borderWidth = 1
        backviewContainer.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func bindData(msg:Message?) {
        messageLabel.text = msg?.message
    }
}

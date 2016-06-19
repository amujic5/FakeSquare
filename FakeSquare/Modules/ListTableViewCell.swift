//
//  ListTableViewCell.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import UIKit
import Kingfisher

final class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(apiPoi apiPoi: APIPoi) {
        titleLabel.text = apiPoi.title
        addressLabel.text = apiPoi.address
        
        if let imageUrl = NSURL(string: apiPoi.imageURL) {
            backgroundImageView.kf_setImageWithURL(imageUrl, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        }
    }

}

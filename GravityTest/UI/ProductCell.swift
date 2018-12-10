//
//  ProductCell.swift
//  GravityTest
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var ivStar: UIImageView!
    @IBOutlet weak var ivProducImage: UIImageView!
    
    func configure(with model : ProductViewModel) {
        self.lbTitle.text = model.title
        self.lbSubtitle.text = model.subtitle
        let tintColor = model.isFavorite ? UIColor.yellow : UIColor.gray
        let image = model.isFavorite ? UIImage(named: "star") : UIImage(named: "star_border")
        self.ivStar.image = image?.withRenderingMode(.alwaysTemplate)
        self.ivStar.tintColor = tintColor
        self.ivProducImage.sd_setImage(with: model.imageUrl)
    }
    
}

//
//  PlaceTableViewCell.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

  @IBOutlet weak var placeLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
  //To configure you cell using viewmodel
  func configure(withViewModel viewModel:PlaceItemPresentable) -> Void {
    let hit = viewModel.hit
    self.placeLabel.text = hit?.administrative[0]
  }
}

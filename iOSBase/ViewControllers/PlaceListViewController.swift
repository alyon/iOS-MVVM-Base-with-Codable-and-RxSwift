//
//  PlaceListViewController.swift
//  iOSBase
//
//  Created by ali uzun on 02/10/2018.
//  Copyright © 2018 ali uzun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlaceListViewController: UIViewController {
  
  @IBOutlet weak var placeTitle: UILabel!
  @IBOutlet weak var placeListView: UITableView!
  
  let cellIdentifier = "placeItemCellIdentifier"
  let placeTableViewCellIdentifier = "PlaceTableViewCell"
  
  var viewModel: PlaceListViewModel?
  
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: placeTableViewCellIdentifier, bundle: nil)
    placeListView.register(nib, forCellReuseIdentifier: cellIdentifier)
    viewModel = PlaceListViewModel()
    let places =  viewModel?.placeHitVariable != nil ? viewModel!.placeHitVariable :  Variable<[PlaceItemPresentable]>([])
    
   places.asObservable().bind(to: placeListView.rx.items(
        cellIdentifier: cellIdentifier, cellType:PlaceTableViewCell.self)){ index, item, cell in
      cell.configure(withViewModel: item)
      }.disposed(by: disposeBag)
  }
}

extension PlaceListViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    print("selected item: \(indexPath.row)")
  }
}

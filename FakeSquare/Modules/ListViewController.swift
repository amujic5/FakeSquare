//
//  ListViewController.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var pois: [APIPoi] = []
    private let _apiManager: APIManager = APIManager()
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _apiManager.pois { (pois) in
            self.pois = pois
            self.tableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }

}


extension ListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return pois.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ListTableViewCell = tableView.dequeueReusableCellWithIdentifier(String(ListTableViewCell), forIndexPath: indexPath) as! ListTableViewCell
        cell.setUp(apiPoi: pois[indexPath.section])
        
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
}
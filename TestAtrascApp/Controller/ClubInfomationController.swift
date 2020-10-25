//
//  ClubInfomationController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/22.
//

import UIKit

class ClubInfomationController: UIViewController {

    @IBOutlet weak var tableViewClubInfo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ClubInfomationController")
        
//        tableViewClubInfo.dataSource = self
//        tableViewClubInfo.delegate = self
        
    }


}

//extension PointCheckController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//
//        return
//    }
//}
//
//
//extension PointCheckController: UITableViewDelegate {
//
//}

//
//  PointCheckController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/22.
//

import UIKit

class PointCheckController: UIViewController {

    @IBOutlet weak var searchBarClubPoint: UISearchBar!
    @IBOutlet weak var tableViewClubPoint: UITableView!
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("PointCheckController")
        
//        tableViewClubPoint.dataSource = self
//        tableViewClubPoint.delegate = self
        
    }
    
    // ログアウトボタン押下
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
        
    }
    

    // 検索バーイベント


}

//extension PointCheckController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
//
//
//extension PointCheckController: UITableViewDelegate {
//    
//}

//
//  ClubInfomationController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/22.
//

import UIKit

class ClubInfomationController: UIViewController {

    @IBOutlet weak var tableViewClubInfo: UITableView!
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    var userName = UserDefaults.standard.string(forKey: "userName")
    var password = UserDefaults.standard.string(forKey: "password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ClubInfomationController")
        
//        tableViewClubInfo.dataSource = self
//        tableViewClubInfo.delegate = self
        
    }


    // ログアウトボタン押下
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

//extension PointCheckController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        return cell
//    }
//}
//
//
//extension PointCheckController: UITableViewDelegate {
//}

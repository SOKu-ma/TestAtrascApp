//
//  ClubIntroDetailMemberViewController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/23.
//

import UIKit
import RealmSwift

class ClubIntroDetailMemberViewController: UIViewController {

    @IBOutlet weak var tableViewClubMember: UITableView!
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    // 引き継ぎプロパティ
    var prpClubName = ""
    
    let clubIntroModels = ClubIntroModel.createModels()
    let sections: [String] = ["部長","メンバー"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NIB(XIB)を使用するための宣言
        let nib = UINib(nibName: "ClubIntroDetailMemberTableViewCell", bundle: nil)
        tableViewClubMember.register(nib, forCellReuseIdentifier: "ClubIntroDetailMemberTableViewCell")
        
        tableViewClubMember.dataSource = self
        tableViewClubMember.delegate = self
        
    }

    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
}

extension ClubIntroDetailMemberViewController: UITableViewDataSource {
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // セクション名を設定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    // セルの総数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 部長
        if section == 0 {
            return 1
        }
        // メンバー
        else {
            // 対象クラブメンバーを取得
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            let predicate = NSPredicate(format: "ClubName == %@", prpClubName)
            let clubRosters = realm.objects(ClubRoster.self).filter(predicate)
            // 部長を除くメンバー数を返す
            return clubRosters.count - 1
        }
    }
    
    // セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // XIBよりセルを生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubIntroDetailMemberTableViewCell", for: indexPath) as! ClubIntroDetailMemberTableViewCell
        
        // Realmよりデータを設定
        cell.setUp(targetSection: indexPath.section, targetRow: indexPath.row, targetClubName: self.prpClubName)
        return cell
    }
}
 
extension ClubIntroDetailMemberViewController: UITableViewDelegate {
}

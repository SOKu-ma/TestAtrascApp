//
//  ClubIntroDetailMemberViewController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/23.
//

import UIKit

class ClubIntroDetailMemberViewController: UIViewController {

    @IBOutlet weak var tableViewClubMember: UITableView!
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    
    let models = ClubIntroModel.createModels()
    
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
            return 10
        }

    }
    
    // セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // XIBよりセルを生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubIntroDetailMemberTableViewCell", for: indexPath) as! ClubIntroDetailMemberTableViewCell
        
        // Modelクラスから取得
//        cell.setUpCell(model: models[indexPath.row])
        
        return cell
    }
    
    
    
}
 
extension ClubIntroDetailMemberViewController: UITableViewDelegate {
    
    
    
}

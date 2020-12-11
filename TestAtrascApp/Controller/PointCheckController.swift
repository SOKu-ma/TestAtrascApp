//
//  PointCheckController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/22.
//

import UIKit
import Alamofire
import RealmSwift

class PointCheckController: UIViewController {
    
    @IBOutlet weak var searchBarClubPoint: UISearchBar!
    @IBOutlet weak var tableViewClubPoint: UITableView!
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    // ローカルホストから取得
    let localUrl = "http://localhost:3000/api"
    
    struct Users: Codable {
        var USERID: String
        var USERNAME: String
        var GRANT: String
        var REMAINING: String
        var USE: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewClubPoint.dataSource = self
        tableViewClubPoint.delegate = self
        
        // NIB(XIB)を使用するための宣言
        let nib = UINib(nibName: "ClubPointTableViewCell", bundle: nil)
        tableViewClubPoint.register(nib, forCellReuseIdentifier: "ClubPointTableViewCell")
        
        // APIを実行
        AF.request(localUrl, method: .get, encoding: JSONEncoding.default).response { response in
            
            switch response.result {
            case .success:
                
                // 取得したJSONをUsersクラスのオブジェクトにパース
                guard let data = response.data else { return }
                guard let json: [Users] = try? JSONDecoder().decode([Users].self, from: data) else { return }

                // Realm登録データを削除
                print(Realm.Configuration.defaultConfiguration.fileURL!)
                let delObj = realm.objects(ClubPoint.self).filter("userName != %@", "")
                if delObj.count > 0 {
                    try! realm.write {
                        realm.delete(delObj)
                    }
                }
                
                for cnt in 0 ..< json.count {

                    let obj = ClubPoint()
                    obj.id = cnt
                    obj.userId = json[cnt].USERNAME
                    obj.userName = json[cnt].USERNAME
                    obj.grant = json[cnt].GRANT
                    obj.remaining = json[cnt].REMAINING
                    obj.use = json[cnt].USE
                    
                    // 取得したデータをRealmへ格納
                    try! realm.write {
                        realm.add(obj)
                    }
                }
                
            case .failure(let error):
                // エラー
                print("error::\(error)")
            
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // ログアウトボタン押下
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
}

extension PointCheckController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Realmの登録件数分
        let models = realm.objects(ClubPoint.self)
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // XIBよりセルを生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubPointTableViewCell", for: indexPath) as! ClubPointTableViewCell
        
        // Realmよりデータを設定
        cell.setUp(targetRow: indexPath.row)
        
        return cell
        
    }
}


extension PointCheckController: UITableViewDelegate {
}

extension PointCheckController: UISearchBarDelegate {
}

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
    
    // RefreshControllerの宣言
    let reflesh = UIRefreshControl()
    
    // API処理用のモデル
    struct Users: Codable {
        var USERID: String
        var USERNAME: String
        var GRANT: String
        var REMAINING: String
        var USE: String
    }
    
    //
    struct Item {
        var userId: String
        var userName: String
        var grant: String
        var remaining: String
        var use: String
    }
    
    var items = [Item]()
    var currentItems = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewClubPoint.dataSource = self
        tableViewClubPoint.delegate = self
        searchBarClubPoint.delegate = self
        
        // NIB(XIB)を使用するための宣言
        let nib = UINib(nibName: "ClubPointTableViewCell", bundle: nil)
        tableViewClubPoint.register(nib, forCellReuseIdentifier: "ClubPointTableViewCell")
        
        // インジケーターの定義
        reflesh.tintColor = UIColor.label
        reflesh.addTarget(self, action: #selector(self.reloadClubPointTableView), for: .valueChanged)
        tableViewClubPoint.refreshControl = reflesh
        
        // Realm登録データ削除
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let delObj = realm.objects(ClubPoint.self).filter("userName != %@", "")
        if delObj.count > 0 {
            try! realm.write {
                realm.delete(delObj)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // API取得
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let Obj = realm.objects(ClubPoint.self).filter("userName != %@", "")

        if Obj.count == 0 {
            getAPI()
        }
    }
    
    // ログアウトボタン押下
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // -- Function --
    // API取得
    private func getAPI() -> Void {
    
        // APIを実行
        AF.request(localUrl, method: .get, encoding: JSONEncoding.default).response { response in
            
            switch response.result {
            case .success:
                
                // 取得したJSONをUsersクラスのオブジェクトにパース
                guard let data = response.data else { return }
                guard let json: [Users] = try? JSONDecoder().decode([Users].self, from: data) else { return }
                
                for cnt in 0 ..< json.count {

                    let obj = ClubPoint()
                    obj.id = cnt
                    obj.userId = json[cnt].USERID
                    obj.userName = json[cnt].USERNAME
                    obj.grant = json[cnt].GRANT
                    obj.remaining = json[cnt].REMAINING
                    obj.use = json[cnt].USE
                    
                    // 取得したデータをRealmへ格納
                    try! realm.write {
                        realm.add(obj)
                    }
                    
                }
                
                self.tableViewClubPoint.reloadData()
                
            case .failure(let error):
                // エラー
                print("error::\(error)")
                
                // アラート作成
                let alert = UIAlertController(title: "クラブポイント取得に失敗しました。", message: "", preferredStyle: .alert)

                // アラート表示
                self.present(alert, animated: true, completion: {
                    // 自動でアラートを閉じる
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        alert.dismiss(animated: true, completion: nil)

                        // 失敗時のユーザへのリアクション（バイブ）
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.error)

                    })
                })
            
            }
        }
        
    }
    // インジケータの処理
    @objc func reloadClubPointTableView(){
        
        // API取得
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let Obj = realm.objects(ClubPoint.self).filter("userName != %@", "")

        if Obj.count == 0 {
            getAPI()
        }
        // セルをリロード
        tableViewClubPoint.reloadData()
        // インジケーターを終了
        self.reflesh.endRefreshing()
    }
    
}

extension PointCheckController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Realmの登録件数分
        let models = realm.objects(ClubPoint.self)
        return models.count
        
//        return currentItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // XIBよりセルを生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubPointTableViewCell", for: indexPath) as! ClubPointTableViewCell
        
        // Realmよりデータを設定
        cell.setUp(targetRow: indexPath.row)
        
//        let rowData = currentItems[indexPath.row]
//        cell.lblUserId.text = rowData.userId
//        cell.lblUserName.text = rowData.userName
//        cell.lblClubPoint.text = rowData.use
        
        return cell
        
    }
}


extension PointCheckController: UITableViewDelegate {
}

extension PointCheckController: UISearchBarDelegate {
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//            currentItems = items
//            tableViewClubPoint.reloadData()
//            return
//        }
//        currentItems = items.filter({ item -> Bool in
//            item.userId.lowercased().contains(searchText.lowercased())
//        })
//        tableViewClubPoint.reloadData()
//    }
}

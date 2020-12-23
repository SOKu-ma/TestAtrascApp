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
//    let url = "http://localhost:3000/api"
    
    // Webから取得
    let url = "https://test202012171836.azurewebsites.net"
    
    // RefreshControllerの宣言
    let reflesh = UIRefreshControl()
    
    // インジケータView
    var activityIndicator = UIActivityIndicatorView()
    
    // 検索窓のMaxLength
    let searchMaxLength = 7
    
    // セクションヘッダ
    let sectionHeader = "社員番号・氏名・残ポイント"
    
    // API処理用のモデル
    struct Users: Codable {
        var USERID: String
        var USERNAME: String
        var GRANT: String
        var REMAINING: String
        var USE: String
    }
    
    struct SearchList {
        var id: Int             // tableViewの表示件数に該当
        var userId: String      // 検索されたuserID
    }
    
    var searchWord = String()
    var listUserId: [SearchList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewClubPoint.dataSource = self
        tableViewClubPoint.delegate = self
        searchBarClubPoint.delegate = self
        
        // NIB(XIB)を使用するための宣言
        let nib = UINib(nibName: "ClubPointTableViewCell", bundle: nil)
        tableViewClubPoint.register(nib, forCellReuseIdentifier: "ClubPointTableViewCell")
        
        // TableView用インジケータ
        reflesh.tintColor = UIColor.label
        reflesh.addTarget(self, action: #selector(self.reloadClubPointTableView), for: .valueChanged)
        tableViewClubPoint.refreshControl = reflesh
        
        // 画面用インジケータ
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        activityIndicator.color = UIColor.label
        self.view.addSubview(activityIndicator)
        
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

            // 画面用インジケーター
            activityIndicator.startAnimating()

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
        AF.request(url, method: .get, encoding: JSONEncoding.default).response { response in
            
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
                self.activityIndicator.stopAnimating()
                
            case .failure(let error):
                // エラー
                print("error::\(error)")
                
                self.activityIndicator.stopAnimating()
                
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
        
        if !searchWord.isEmpty {
            searchWord = ""
        }
        
        // セルをリロード
        tableViewClubPoint.reloadData()
        // インジケーターを終了
        self.reflesh.endRefreshing()
    }
    
}

extension PointCheckController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !searchWord.isEmpty {

            let str = "\(searchWord)*"
            let predicate = NSPredicate(format: "userId LIKE %@", str)
            let models = realm.objects(ClubPoint.self).filter(predicate)
            
            if listUserId.count > 0 {
                listUserId.removeAll()
            }
            
            if models.count > 0 {
                // 近似検索で取得できた「UserId」をリストに格納
                for cnt in 0 ..< models.count {
                    listUserId.append(SearchList(id: cnt, userId: models[cnt].userId))
                    
                }
            }
            return models.count
        }
        else {
            // Realmの登録件数分
            let models = realm.objects(ClubPoint.self)
            return models.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // XIBよりセルを生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubPointTableViewCell", for: indexPath) as! ClubPointTableViewCell
        
        // Realmよりデータを設定
        if searchWord == "" {
            cell.setUp(targetRow: indexPath.row, searchWord: searchWord)
        }
        else {
            cell.searchWordSetUp(targetUserId: listUserId[indexPath.row].userId)
        }
        
        return cell
        
    }
}


extension PointCheckController: UITableViewDelegate {
}

extension PointCheckController: UISearchBarDelegate {
    
    // 検索バーのワードを取得
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            
            searchWord = ""
            tableViewClubPoint.reloadData()
            return
            
        }
        
        if searchText.count > 8 {
            // 8文字以上が入力された場合、先頭7文字を取得
            searchWord = String(searchText.prefix(searchMaxLength))
        }
        else {
            searchWord = searchText
            tableViewClubPoint.reloadData()
        }
    }
    
    // 検索キータップ時に呼び出されるメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
        
}

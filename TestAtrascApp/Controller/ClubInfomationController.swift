//
//  ClubInfomationController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/22.
//

import UIKit
import Alamofire
import RealmSwift

class ClubInfomationController: UIViewController {
    
    @IBOutlet weak var tableViewClubInfo: UITableView!
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    var userName = UserDefaults.standard.string(forKey: "userName")
    var password = UserDefaults.standard.string(forKey: "password")
    
    // API処理用のモデル
    struct clubInfo: Codable {
        var name: String
        var date: String
        var detail: String
    }
    
    // RefreshControllerの宣言
    let reflesh = UIRefreshControl()
    
    // インジケータView
    var activityIndicator = UIActivityIndicatorView()
    
    // 投稿フォーム画面遷移ボタン
    private var btnSend = UIButton()
    
    //
    let url = "http://localhost:8080/get/"
    
    var arrRowNum: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NIB(XIB)を使用するための宣言
        let nib = UINib(nibName: "ClubInfoTableViewCell", bundle: nil)
        tableViewClubInfo.register(nib, forCellReuseIdentifier: "clubInfoTableViewCell")
        
        tableViewClubInfo.dataSource = self
        tableViewClubInfo.delegate = self
        
        // 送信ボタン
        btnSend.setTitle("投稿", for: .normal)
        btnSend.setTitleColor(.white, for: .normal)
        btnSend.backgroundColor = .systemOrange
        btnSend.layer.cornerRadius = 10
        btnSend.addTarget(self, action: #selector(self.btnSendTapped(_:)), for: .touchDown)
        btnSend.addTarget(self, action: #selector(self.btnSendTouchDragExit(_:)), for: .touchDragExit)
        btnSend.addTarget(self, action: #selector(self.btnSendTouchUpInside), for: .touchUpInside)
        self.view.addSubview(btnSend)
        btnSend.translatesAutoresizingMaskIntoConstraints = false
        btnSend.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/6).isActive = true
        btnSend.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnSend.bottomAnchor.constraint(equalTo: self.self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        btnSend.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        
        // TableView用インジケータ
        reflesh.tintColor = UIColor.label
        reflesh.addTarget(self, action: #selector(self.reloadClubPointTableView), for: .valueChanged)
        tableViewClubInfo.refreshControl = reflesh
        
        // 画面用インジケータ
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        activityIndicator.color = UIColor.label
        self.view.addSubview(activityIndicator)
        
        // Realm登録データ削除
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let delObj = realm.objects(ClubInfo.self)
        if delObj.count > 0 {
            try! realm.write {
                realm.delete(delObj)
            }
        }
        
        // API取得
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let Obj = realm.objects(ClubInfo.self)
        
        // 画面用インジケーター
        activityIndicator.startAnimating()
        
        if Obj.count == 0 {
            getAPI()
        }
        self.activityIndicator.stopAnimating()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        getAPI()
//        tableViewClubInfo.reloadData()
//    }
    
    // -- Function --
    // API取得
    private func getAPI() -> Void {
        
        // APIを実行
        AF.request(url, method: .get, encoding: JSONEncoding.default).response { response in
            
            switch response.result {
            case .success:
                
                // 取得したJSONをUsersクラスのオブジェクトにパース
                guard let data = response.data else { return }
                guard let json: [clubInfo] = try? JSONDecoder().decode([clubInfo].self, from: data) else { return }
                
                for cnt in 0 ..< json.count {
                    
                    let obj = ClubInfo()
                    obj.Id = cnt
                    obj.ClubName = json[cnt].name
                    obj.Date = json[cnt].date
                    obj.Detail = json[cnt].detail
                    
                    // 取得したデータをRealmへ格納
                    try! realm.write {
                        realm.add(obj)
                    }
                    
                }
                
                self.tableViewClubInfo.reloadData()
            //                self.activityIndicator.stopAnimating()
            
            case .failure(let error):
                // エラー
                print("error::\(error)")
                
                //                self.activityIndicator.stopAnimating()
                
                // アラート作成
                let alert = UIAlertController(title: "クラブ情報の取得に失敗しました。", message: "", preferredStyle: .alert)
                
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
        // Realm登録データ削除
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let delObj = realm.objects(ClubInfo.self)
        if delObj.count > 0 {
            try! realm.write {
                realm.delete(delObj)
            }
        }
        // API取得
        getAPI()
        // セルをリロード
        tableViewClubInfo.reloadData()
        // インジケーターを終了
        self.reflesh.endRefreshing()
        self.activityIndicator.stopAnimating()
    }
    
    // 送信ボタン押下時（ボタンを縮小）
    @objc func btnSendTapped(_ sender : UIButton) {
        // ボタンを縮小（アニメーション）
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    // 送信ボタン押下（ボタン押下 → ボタン外にドラッグ時）
    @objc func btnSendTouchDragExit(_ sender : UIButton) {
        // ボタンの縮小を元に戻す（アニメーション）
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    // 送信ボタン押下(離れる直前)
    @objc func btnSendTouchUpInside(_ sender : UIButton) {
        // 投稿フォーム画面へ遷移
        let sb: UIStoryboard = self.storyboard!
        let sendVC = sb.instantiateViewController(identifier: "sendClubInfoViewController") as! SendClubInfoViewController
        sendVC.childCallBack = { self.callBack() }
        self.present(sendVC, animated: true, completion: nil)
            
        // ボタンの縮小を元に戻す
        btnSendTouchDragExit(sender)
    }
    
    // 
    func callBack() {
        tableViewClubInfo.reloadData()
    }
    
    // ログアウトボタン押下
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension ClubInfomationController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let models = realm.objects(ClubInfo.self)
        if models.count > 0 {
            return models.count
        }
        else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // XIBよりセルを生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "clubInfoTableViewCell", for: indexPath) as! ClubInfoTableViewCell
        cell.setUp(indexPathRow: indexPath.row)
//        arrRowNum[indexPath.row] cell.rowNum
        arrRowNum.append(cell.rowNum)
        print("arrRowNum[cell.rowNum]::\(arrRowNum[cell.rowNum])")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(60)
        return height
    }
}


extension ClubInfomationController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // クラブ情報詳細画面へ遷移
        let sb: UIStoryboard = self.storyboard!
        let clubInfoVC = sb.instantiateViewController(identifier: "clubInfomationDetailController") as! ClubInfomationDetailController
        
        // 引き継ぎプロパティ
        clubInfoVC.indexRow = indexPath.row
        
        
        
        self.navigationController?.pushViewController(clubInfoVC, animated: true)
//        self.present(clubInfoVC, animated: true, completion: nil)
    }
}

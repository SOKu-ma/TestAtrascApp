//
//  SendClubInfoViewController.swift
//  TestAtrascApp
//
//  Created by 太田修平 on 2021/01/17.
//

import UIKit
import Alamofire
import RealmSwift

class SendClubInfoViewController: UIViewController {
    
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnSend: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var btnClubName: UIButton!
    @IBOutlet weak var btnClubDetail: UIButton!
    @IBOutlet weak var btnClubDetailBottomAnchor: NSLayoutConstraint!
    
    var isBack = false          // MemoTextViewからの戻りかを判定
    var clubDetail = String()   // 活動詳細
    
    
    var arrClubs: [UIMenuElement] = []
    // テスト用
    let arrClub: [String] = ["野球部","サッカー部","ゴルフ部","テニス部"]
    
    // インジケータView
    var activityIndicator = UIActivityIndicatorView()
    
    //クロージャを保持するためのプロパティ
    var childCallBack: (() -> Void)?
    
    // cosmosDB接続用API
    var cosmosDB_URL: String = "https://testatrascapp20210120.azurewebsites.net/api/HttpTrigger1?code=SKHuu1OIiw49k9KwL6gk5okcnMUHouJY1DGS2pirsL9YjvJhKdf6gg==&"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
        
        // クラブ名ボタン
        self.btnClubName.layer.borderColor = UIColor.lightGray.cgColor
        self.btnClubName.layer.borderWidth = 0.25
        self.btnClubName.layer.cornerRadius = 5
        self.btnClubName.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.btnClubName.titleLabel?.numberOfLines = 0
        
        // 活動詳細ボタンの整形
        self.btnClubDetail.layer.borderColor = UIColor.lightGray.cgColor
        self.btnClubDetail.layer.borderWidth = 0.25
        self.btnClubDetail.layer.cornerRadius = 5
        self.btnClubDetail.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.btnClubDetail.titleLabel?.numberOfLines = 0
        
        // クラブ名取得
        for cnt in 0 ..< arrClub.count {
            let tabMenu = UIAction(title: (arrClub[cnt]), image: nil) { (_) in
                self.btnClubName.setTitle(self.arrClub[cnt], for: .normal)
            }
            arrClubs.append(tabMenu)
        }
        
        let menu = UIMenu(title: "クラブを選択", image: nil, identifier: nil, options: .destructive, children: arrClubs)
        if #available(iOS 14.0, *) {
            btnClubName.showsMenuAsPrimaryAction = true
            btnClubName.menu = menu
        } else {
            // Fallback on earlier versions
        }
        
        // 画面用インジケータ
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        activityIndicator.color = UIColor.label
        self.view.addSubview(activityIndicator)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.isBack {
            if self.clubDetail != " タップしてメモを追加" {
                self.btnClubDetail.setTitle(self.clubDetail, for: .normal)
                self.btnClubDetail.setTitleColor(.label, for: .normal)
                self.btnClubDetail.sizeToFit()
                let resizeHeight = self.btnClubDetail.frame.size.height
                self.btnClubDetailBottomAnchor.constant = CGFloat(resizeHeight)
                isBack = false
            }
            else {
                self.btnClubDetail.setTitle(self.clubDetail, for: .normal)
                self.btnClubDetail.setTitleColor(.lightGray, for: .normal)
                self.btnClubDetail.sizeToFit()
                isBack = false
            }
        }
    }
    
    // -- 活動詳細ボタン押下 --
    @IBAction func btnClubDetailTapped(_ sender: UIButton) {
        let sb: UIStoryboard = self.storyboard!
        let clubInfoTextVC = sb.instantiateViewController(identifier: "clubInfoTextViewController") as! ClubInfoTextViewController
        clubInfoTextVC.modalPresentationStyle = .fullScreen
        clubInfoTextVC.clubDetailText = btnClubDetail.currentTitle!
        self.present(clubInfoTextVC, animated: true, completion: nil)
    }
    
    
    @IBAction func btnCancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // -- 入力パラメータでAPI実行 --
    @IBAction func btnSendTapped(_ sender: UIBarButtonItem) {
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        timeFormatter.dateFormat = "HH時mm分"
        let date = dateFormatter.string(from: datePicker.date) + timeFormatter.string(from: datePicker.date)
        
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        // Postするパラメータ
        let parameters:[String: Any] = [
            "name": (btnClubName.titleLabel?.text)!,
            "date": date,
            "detail": (btnClubDetail.titleLabel?.text)!
        ]
        
        // 画面用インジケーター
        activityIndicator.startAnimating()
        
        let api = "http://localhost:8080/send/"
        print("api::\(api)")
                
        AF.request(api, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
            
            switch response.result {
            case .success:
                // success
                print("成功")

                self.activityIndicator.stopAnimating()
                
                // アラート作成
                let alert = UIAlertController(title: "送信完了しました。", message: "", preferredStyle: .alert)
                
                // アラート表示
                self.present(alert, animated: true, completion: {
                    // 自動でアラートを閉じる
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        alert.dismiss(animated: true, completion: nil)
                        // ユーザへのリアクション（バイブ）
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.error)
                        self.dismiss(animated: true) {
                            self.childCallBack?()
                        }
                    })
                })
                
            case .failure(let error):
                // エラー
                print("error::\(error)")
                self.activityIndicator.stopAnimating()
                
                // アラート作成
                let alert = UIAlertController(title: "送信に失敗しました。", message: "", preferredStyle: .alert)

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
}

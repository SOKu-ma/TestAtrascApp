//
//  ClubIntroDuctionDetailViewController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/23.
//

import UIKit

class ClubIntroDuctionDetailViewController: UIViewController {

    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var btnMenber: UIButton!
    @IBOutlet weak var btnActivityContent: UIButton!
    @IBOutlet weak var btnActivityLandscape: UIButton!
    
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    
    // 引き継ぎプロパティ
    var prpClubName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 値の引き継ぎ
        lblClubName.text = prpClubName
        
        // 各種ボタンの整形
        // メンバー
        btnMenber.layer.borderWidth = 1
        btnMenber.layer.cornerRadius = 20
        btnMenber.layer.borderColor = UIColor.systemBlue.cgColor
        btnMenber.layer.backgroundColor = UIColor.systemBlue.cgColor
        btnMenber.setTitleColor(UIColor.white, for: .normal)
        
        // 活動内容
        btnActivityContent.layer.borderWidth = 1
        btnActivityContent.layer.cornerRadius = 20
        btnActivityContent.layer.borderColor = UIColor.systemBlue.cgColor
        btnActivityContent.layer.backgroundColor = UIColor.systemBlue.cgColor
        btnActivityContent.setTitleColor(UIColor.white, for: .normal)
        
        // 活動風景
        btnActivityLandscape.layer.borderWidth = 1
        btnActivityLandscape.layer.cornerRadius = 20
        btnActivityLandscape.layer.borderColor = UIColor.systemBlue.cgColor
        btnActivityLandscape.layer.backgroundColor = UIColor.systemBlue.cgColor
        btnActivityLandscape.setTitleColor(UIColor.white, for: .normal)
    }
    
    // メンバーボタンタップ時
    @IBAction func didTapMenber(_ sender: UIButton) {
        
        print("didTapMenber")
        
        // クラブ情報画面へ遷移
        let storyboard: UIStoryboard = self.storyboard!
        let clubInfo = storyboard.instantiateViewController(identifier: "ClubIntroDetailMemberView")
//        self.present(clubInfo, animated: true, completion: nil)
        self.navigationController?.pushViewController(clubInfo, animated: true)
        
    }
    
    // 活動内容ボタンタップ時
    @IBAction func didTapActivityContent(_ sender: UIButton) {
        
        print("didTapActivityContent")
        
    }
    
    
    // 活動風景ボタンタップ時
    @IBAction func didTapActivityLandscape(_ sender: UIButton) {
        
        print("didTapActivityLandscape")
        
    }
    
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
}

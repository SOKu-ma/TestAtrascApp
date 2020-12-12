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
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    // 引き継ぎプロパティ
    var prpClubName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 値の引き継ぎ
        lblClubName.text = prpClubName
        // 各種ボタンの整形
        // メンバー
        self.modButton(btnMenber)
        // 活動内容
        self.modButton(btnActivityContent)
    }
    
    // メンバーボタンタップ時
    @IBAction func didTapMenber(_ sender: UIButton) {
        
        // クラブ情報画面へ遷移
        let storyboard: UIStoryboard = self.storyboard!
        let clubInfo = storyboard.instantiateViewController(identifier: "ClubIntroDetailMemberView") as! ClubIntroDetailMemberViewController
        // 引き継ぎプロパティ
        clubInfo.prpClubName = lblClubName.text!
        
        self.navigationController?.pushViewController(clubInfo, animated: true)
        
    }
    
    // 活動内容ボタンタップ時
    @IBAction func didTapActivityContent(_ sender: UIButton) {
        print("didTapActivityContent")
    }
    
    
    // ログアウト処理
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // 共通：ボタン整形
    private func modButton(_ button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
}

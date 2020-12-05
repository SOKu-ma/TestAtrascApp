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
        self.modButton(btnMenber)
//        btnMenber.layer.borderWidth = 1
//        btnMenber.layer.cornerRadius = 20
//        btnMenber.layer.borderColor = UIColor.systemBlue.cgColor
//        btnMenber.layer.backgroundColor = UIColor.systemBlue.cgColor
//        btnMenber.setTitleColor(UIColor.white, for: .normal)
        
        // 活動内容
        self.modButton(btnActivityContent)
//        btnActivityContent.layer.borderWidth = 1
//        btnActivityContent.layer.cornerRadius = 20
//        btnActivityContent.layer.borderColor = UIColor.systemBlue.cgColor
//        btnActivityContent.layer.backgroundColor = UIColor.systemBlue.cgColor
//        btnActivityContent.setTitleColor(UIColor.white, for: .normal)
        
        // 活動風景
        self.modButton(btnActivityLandscape)
//        btnActivityLandscape.layer.borderWidth = 1
//        btnActivityLandscape.layer.cornerRadius = 20
//        btnActivityLandscape.layer.borderColor = UIColor.systemBlue.cgColor
//        btnActivityLandscape.layer.backgroundColor = UIColor.systemBlue.cgColor
//        btnActivityLandscape.setTitleColor(UIColor.white, for: .normal)
    }
    
    // メンバーボタンタップ時
    @IBAction func didTapMenber(_ sender: UIButton) {
        
        print("didTapMenber")
        
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
    
    
    // 活動風景ボタンタップ時
    @IBAction func didTapActivityLandscape(_ sender: UIButton) {
        
        print("didTapActivityLandscape")
        
    }
    
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
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

//
//  LoginViewController.swift
//  TestAtrascApp
//
//  Created by 太田修平 on 2020/10/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタンの整形
        // ログイン
        btnLogin.layer.borderColor = UIColor.gray.cgColor
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 10
        btnLogin.layer.shadowOpacity = 0.7
        btnLogin.layer.shadowRadius = 3
        btnLogin.layer.shadowColor = UIColor.black.cgColor
        btnLogin.layer.shadowOffset = CGSize(width: 5, height: 5)

    }
    
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        
        // ここで本来は認証を行う
        // とりあえずメインメニュー(クラブ情報画面？？)へ遷移
        let storyboard: UIStoryboard = self.storyboard!
        let clubInfo = storyboard.instantiateViewController(identifier: "MainMenuTab")
        clubInfo.modalPresentationStyle = .fullScreen
        self.present(clubInfo, animated: true, completion: nil)
//        self.navigationController?.pushViewController(clubInfo, animated: true)
        
        
        
    }
    
    
}

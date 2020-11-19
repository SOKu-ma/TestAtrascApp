//
//  LoginViewController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/24.
//

import UIKit

class LoginViewController: UIViewController {

    // ユーザID
    @IBOutlet weak var contViewUserID: UIView!
    @IBOutlet weak var imageUserID: UIImageView!
    @IBOutlet weak var textUserID: UITextField!
    
    
    // パスワード
    @IBOutlet weak var contViewPW: UIView!
    @IBOutlet weak var imagePW: UIImageView!
    @IBOutlet weak var textPW: UITextField!
    
    // ログインボタン
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタンの整形
        // ログイン
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 20
        btnLogin.layer.borderColor = UIColor.systemBlue.cgColor
        btnLogin.layer.backgroundColor = UIColor.systemBlue.cgColor
        btnLogin.setTitleColor(UIColor.white, for: .normal)

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

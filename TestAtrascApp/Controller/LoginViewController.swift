//
//  LoginViewController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/24.
//

import UIKit
import LocalAuthentication

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
        
        // テキストフィールドの整形
        //
        contViewUserID.backgroundColor = UIColor.white
//        contViewUserID.backgroundColor = UIColor.systemBackground
        contViewUserID.alpha = 0.5
        contViewUserID.layer.borderWidth = 1
        contViewUserID.layer.cornerRadius = 10
//        contViewUserID.layer.borderColor = UIColor.systemBackground.cgColor
        contViewUserID.layer.borderColor = UIColor.lightGray.cgColor
//        contViewUserID.layer.borderColor = UIColor.white.cgColor
        textUserID.borderStyle = .none
        
        contViewPW.backgroundColor = UIColor.white
        contViewPW.alpha = 0.5
        contViewPW.layer.borderWidth = 1
        contViewPW.layer.cornerRadius = 10
//        contViewPW.layer.borderColor = UIColor.systemBackground.cgColor
        contViewPW.layer.borderColor = UIColor.lightGray.cgColor
//        contViewPW.layer.borderColor = UIColor.white.cgColor
        textPW.borderStyle = .none
        
        // ボタンの整形
        // ログイン
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 10
        btnLogin.layer.borderColor = UIColor.systemBlue.cgColor
        btnLogin.layer.backgroundColor = UIColor.systemBlue.cgColor
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        
        // textFieldのプロパティ定義
        textUserID.keyboardType = UIKeyboardType.default
        textPW.keyboardType = UIKeyboardType.alphabet
        textPW.isSecureTextEntry = true
        
        // delegate宣言
        textUserID.delegate = self
        textPW.delegate = self
    }
    
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        
        // 認証
        if (textUserID.text != "") && (textPW.text != "") {
            
            // ユーザマスタのデータと比較
            // エラーメッセージ：「社員番号またはパスワードに誤りがあります。」
            
            // 一致する「社員番号」がない場合
            
            
            // 「社員番号」に紐づく「パスワード」がない場合
            
            
            // 認証できた場合
            
            // メインメニュー(クラブ情報画面？？)へ遷移
            let storyboard: UIStoryboard = self.storyboard!
            let clubInfo = storyboard.instantiateViewController(identifier: "MainMenuTab")
            clubInfo.modalPresentationStyle = .fullScreen
            self.present(clubInfo, animated: true, completion: nil)
    //        self.navigationController?.pushViewController(clubInfo, animated: true)
            
            
        }
        else {
            // アラート
            let alert = UIAlertController(title: "ユーザー名とパスワードの入力は必須です", message: "", preferredStyle: .alert)
            // アクション
            let action = UIAlertAction(title: "OK", style: .cancel)
            // アラートにアクションを追加する
            alert.addAction(action)
            // アラートを表示
            present(alert, animated: true, completion: nil)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボード閉じる
        textField.resignFirstResponder()
        return true
    }
    
    
    
}

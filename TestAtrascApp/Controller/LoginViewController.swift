//
//  LoginViewController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/24.
//

import UIKit
import LocalAuthentication
import RealmSwift

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
        // ユーザID
        modView(contViewUserID)
        textUserID.borderStyle = .none
        
        // パスワード
        modView(contViewPW)
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
    
    override func viewDidDisappear(_ animated: Bool) {
        // テキストフィールドからクリア
        self.textUserID.text = ""
        self.textPW.text = ""
    }
    
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        
        // 認証
        if (textUserID.text != "") && (textPW.text != "") {
            
            // ユーザマスタのデータと比較
            // エラーメッセージ：「社員番号またはパスワードに誤りがあります。」
            // 一致する「社員番号」がない場合
            // 「社員番号」に紐づく「パスワード」がない場合
            
            // 認証できた場合
            // UserDefaultsに保存
            let ud = UserDefaults.standard
            ud.set(textUserID.text, forKey: "userName")
            ud.set(textPW.text, forKey: "password")
            
            // メインメニュー(クラブ情報画面)へ遷移
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
    
    // 共通：Viewの整形
    func modView(_ view: UIView) {
        view.backgroundColor = UIColor.white
        view.alpha = 0.5
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
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

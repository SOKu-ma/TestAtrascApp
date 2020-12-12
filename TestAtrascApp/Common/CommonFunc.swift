//
//  CommonFunc.swift
//  TestAtrascApp
//
//  Created by Shuhei Ota on 2020/12/03.
//

import Foundation
import UIKit
import RealmSwift

// Realmの宣言
let realm = try! Realm()

extension UIAlertController {
    
    // ログアウト処理（アラート）
    class func logoutAlert() -> UIAlertController {
        
        let alertVC: UIAlertController = UIAlertController(title: "", message: "ログアウトしますか？", preferredStyle: .alert)
        let cancelAction:UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action:UIAlertAction!) -> Void in
        })
        
        let deleteAction:UIAlertAction =
            UIAlertAction(title: "ログアウト",
                          style: .destructive,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            // 処理
                            UserDefaults.standard.removeObject(forKey: "username")
                            UserDefaults.standard.removeObject(forKey: "password")
                            UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
                          })
        
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(deleteAction)
        
        return alertVC
    }
    
}

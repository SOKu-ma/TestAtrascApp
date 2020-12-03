//
//  UserMaster.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/11/20.
//

import Foundation
import RealmSwift

// 社員マスタ
class User: Object {
    
    @objc dynamic var UserID = 0              // 社員番号
    @objc dynamic var UserName = ""           // 氏名
    @objc dynamic var DepartmentName = ""     // 部署名
    @objc dynamic var MailAdress = ""         // メールアドレス
    
    override static func primaryKey() -> String? {
        return "UserID"
    }
}

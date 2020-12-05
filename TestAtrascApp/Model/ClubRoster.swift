//
//  ClubRoster.swift
//  TestAtrascApp
//
//  Created by 太田修平 on 2020/12/05.
//

import Foundation
import RealmSwift

// クラブ名簿
class ClubRoster: Object {
    
    @objc dynamic var Id = 0                  // Id
    @objc dynamic var UserID = 0              // 社員番号
    @objc dynamic var UserName = ""           // 氏名
    @objc dynamic var DepartmentName = ""     // 部署名
    @objc dynamic var MailAdress = ""         // メールアドレス
    @objc dynamic var ClubName = ""           // 所属クラブ
    @objc dynamic var isDirector = 0          // クラブ部長フラグ
    
    override static func primaryKey() -> String? {
        return "Id"
    }
    
}

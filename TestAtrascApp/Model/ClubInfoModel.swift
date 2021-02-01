//
//  ClubInfoModel.swift
//  TestAtrascApp
//
//  Created by 太田修平 on 2021/01/28.
//

import Foundation
import RealmSwift

// クラブ情報モデル
class ClubInfo: Object, Codable {

    @objc dynamic var Id = 0                  // Id
    @objc dynamic var ClubName = ""           // クラブ名
    @objc dynamic var Date = ""               // 活動日時
    @objc dynamic var Detail = ""             // 活動詳細
    
    override static func primaryKey() -> String? {
        return "Id"
    }
}

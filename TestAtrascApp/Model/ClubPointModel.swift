//
//  ClubPointModel.swift
//  TestAtrascApp
//
//  Created by Shuhei Ota on 2020/12/10.
//

import Foundation
import RealmSwift

class ClubPoint: Object, Codable {
    
    @objc dynamic var id: Int = 0                    // ID
    @objc dynamic var userId: String = ""            // 社員番号
    @objc dynamic var userName: String = ""          // 氏名
    @objc dynamic var grant: String = ""             // 本年度付与ポイント
    @objc dynamic var remaining: String = ""         // 残ポイント
    @objc dynamic var use: String = ""               // 使用ポイント

    override public static func primaryKey() -> String? {
        return "id"
    }
    
}

//
//  ClubPointTableViewCell.swift
//  TestAtrascApp
//
//  Created by 太田修平 on 2020/12/06.
//

import UIKit
import RealmSwift

class ClubPointTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblClubPoint: UILabel!
    
    let realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        lblUserId.text = ""
        lblUserName.text = ""
        lblClubPoint.text = ""
    }
    
    func setUp(targetRow: Int) {
        
        //
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Realmよりデータを取得
        let predicate = NSPredicate(format: "id == \(targetRow)")
//        let predicate = NSPredicate(format: "id == 0")
        let models = self.realm.objects(ClubPoint.self)
        if models.count > 0 {
            let target = self.realm.objects(ClubPoint.self).filter(predicate).first
            
            self.lblUserId.text = target?.userId
            self.lblUserName.text = target?.userName
            self.lblClubPoint.text = target?.remaining
        }
    }
    
}

//
//  ClubIntroDetailMemberTableViewCell.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/23.
//

import UIKit
import RealmSwift

class ClubIntroDetailMemberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDepartment: UILabel!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMailAdress: UILabel!
    
    let realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.lblDepartment.text = ""
        self.lblUserId.text = ""
        self.lblName.text = ""
        self.lblMailAdress.text = ""
    }
    
    // 所属メンバーを設定
    func setUp(targetSection: Int, targetRow: Int, targetClubName: String) {
        
        var predicate = NSPredicate()
        var model = ClubRoster()
        
        if targetSection == 0 {
            predicate = NSPredicate(format: "isDirector == 0 && ClubName == %@", targetClubName)
            let preModel = realm.objects(ClubRoster.self).filter(predicate)
            if preModel.count > 0 {
                model = realm.objects(ClubRoster.self).filter(predicate).first!
            }
            else {
                return
            }
        }
        else {
            predicate = NSPredicate(format: "isDirector == 1 && ClubName == %@", targetClubName)
            let preModel = realm.objects(ClubRoster.self).filter(predicate).sorted(byKeyPath: "Id")
            model = preModel[targetRow]
        }
        
        // 値を設定
        if model.DepartmentName != "" {
            lblDepartment.text = model.DepartmentName
        }
        if String(model.UserID) != "" {
            lblUserId.text = String(model.UserID)
        }
        if String(model.UserName) != "" {
            lblName.text = String(model.UserName)
        }
        if model.MailAdress != "" {
            lblMailAdress.text = model.MailAdress
        }
        
    }
    
    
}

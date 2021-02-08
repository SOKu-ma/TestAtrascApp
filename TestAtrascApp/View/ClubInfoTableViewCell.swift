//
//  ClubInfoTableViewCell.swift
//  TestAtrascApp
//
//  Created by Shuhei Ota on 2020/10/26.
//

import UIKit
import RealmSwift

class ClubInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblClubInfo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgClub: UIImageView!
    
    var rowNum = Int()
    
    let modelImage = ClubIntroModel.createModels()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        lblClubName.text = ""
        lblClubInfo.text = ""
        lblDate.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(indexPathRow: Int) {
        
        // Realmより取得
//        let predicate = NSPredicate(format: "Id == \(indexPathRow)")
        let predicate = NSPredicate(format: "Order == \(indexPathRow)")
        let model = realm.objects(ClubInfo.self).filter(predicate).first
        
        self.lblClubName.text = model?.ClubName
        self.lblClubInfo.text = model?.Detail
        self.lblDate.text = model?.Date
        if model?.Id != nil {
            self.rowNum = model!.Id
        }
        for cnt in 0 ..< modelImage.count {
            if modelImage[cnt].clubName == model?.ClubName {
                self.imgClub.image = UIImage(named: modelImage[cnt].clubImage)
            }
        }
    }
    
}

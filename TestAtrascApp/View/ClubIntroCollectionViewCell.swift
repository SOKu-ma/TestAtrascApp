//
//  ClubIntroCollectionViewCell.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/23.
//

import UIKit

class ClubIntroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageClub: UIImageView!
    @IBOutlet weak var lblClub: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // セル再利用時に初期化
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblClub.text = ""
    }
    
    // ClubIntroModelクラスから値を設定
    func setUpCell(model: ClubIntroModel) {
        
        // クラブ名を設定
        lblClub.text = model.clubName
        
        // セルのレイアウト整形
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
        
    }

    // クラブの画像を設定
    func setUpImage(model: ClubIntroModel) {
        
        // 画像を設定
        imageClub.image = UIImage(named: model.clubImage)
        
        
        
    }
    
}

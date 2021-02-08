//
//  ClubInfomationDetailController.swift
//  TestAtrascApp
//
//  Created by 太田修平 on 2021/01/17.
//

import UIKit
import RealmSwift

class ClubInfomationDetailController: UIViewController {

    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblKaisaiDate: UILabel!
    @IBOutlet weak var lblKaisaiPlace: UILabel!
    @IBOutlet weak var lblClubInfoDetail: UILabel!
    
    // -- 引き継ぎプロパティ --
    var indexRow = Int()
    var clubName = String()
    var kaisaiDate = String()
    var KaisaiPlace = String()
    var clubInfoDetail = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}

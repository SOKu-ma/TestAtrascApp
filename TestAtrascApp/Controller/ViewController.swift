//
//  ViewController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnClubInfo: UIButton!
    @IBOutlet weak var btnClubIntro: UIButton!
    @IBOutlet weak var btnCheckPoint: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // 各種ボタンの整形
        // クラブ情報
        btnClubInfo.layer.borderColor = UIColor.gray.cgColor
        btnClubInfo.layer.borderWidth = 1
        btnClubInfo.layer.cornerRadius = 10
        btnClubInfo.layer.shadowOpacity = 0.7
        btnClubInfo.layer.shadowRadius = 3
        btnClubInfo.layer.shadowColor = UIColor.black.cgColor
        btnClubInfo.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        // クラブ紹介
        btnClubIntro.layer.borderColor = UIColor.gray.cgColor
        btnClubIntro.layer.borderWidth = 1
        btnClubIntro.layer.cornerRadius = 10
        btnClubIntro.layer.shadowOpacity = 0.7
        btnClubIntro.layer.shadowRadius = 3
        btnClubIntro.layer.shadowColor = UIColor.black.cgColor
        btnClubIntro.layer.shadowOffset = CGSize(width: 5, height: 5)

        // クラブポイント確認
        btnCheckPoint.layer.borderColor = UIColor.gray.cgColor
        btnCheckPoint.layer.borderWidth = 1
        btnCheckPoint.layer.cornerRadius = 10
        btnCheckPoint.layer.shadowOpacity = 0.7
        btnCheckPoint.layer.shadowRadius = 3
        btnCheckPoint.layer.shadowColor = UIColor.black.cgColor
        btnCheckPoint.layer.shadowOffset = CGSize(width: 5, height: 5)

    }
    
    // クラブ情報ボタンタップイベント
    @IBAction func didTapClubInfo(_ sender: UIButton) {
        
        // クラブ情報画面へ遷移
        let storyboard: UIStoryboard = self.storyboard!
        let clubInfo = storyboard.instantiateViewController(identifier: "ClubInfomation")
//        self.present(clubInfo, animated: true, completion: nil)
        self.navigationController?.pushViewController(clubInfo, animated: true)
    }
    
    // クラブ紹介ボタンタップイベント
    @IBAction func didTapClubIntro(_ sender: UIButton) {

        // クラブ紹介画面へ遷移
        let storyboard: UIStoryboard = self.storyboard!
        let clubIntro = storyboard.instantiateViewController(identifier: "ClubIntroduction")
//        self.present(clubIntro, animated: true, completion: nil)
        self.navigationController?.pushViewController(clubIntro, animated: true)
    }
    

    
    // クラブポイントボタン確認タップイベント
    @IBAction func didTapCheckPoint(_ sender: UIButton) {
        
        // クラブポイント確認画面へ遷移
        let storyboard: UIStoryboard = self.storyboard!
        let checkPoint = storyboard.instantiateViewController(identifier: "CheckPoint")
//        self.present(checkPoint, animated: true, completion: nil)
        self.navigationController?.pushViewController(checkPoint, animated: true)
    }
    
}


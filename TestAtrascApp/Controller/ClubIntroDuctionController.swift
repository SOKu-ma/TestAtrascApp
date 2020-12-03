//
//  ClubIntroDuctionController.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/22.
//

import UIKit

class ClubIntroDuctionController: UIViewController {

    let models = ClubIntroModel.createModels()
    
    @IBOutlet weak var colViewClub: UICollectionView!
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colViewClub.dataSource = self
        colViewClub.delegate = self
        
        // NIB(XIB)を使用するための宣言
        let nib = UINib(nibName: "ClubIntroCollectionViewCell", bundle: nil)
        colViewClub.register(nib, forCellWithReuseIdentifier: "ClubIntroCollectionViewCell")
        
        // セルの大きさを設定
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width / 3 - 10, height: 200)
        colViewClub.collectionViewLayout = layout

    }
    
    // ログアウトボタン押下
    @IBAction func btnLogoutTapped(_ sender: UIBarButtonItem) {
        // ログアウト処理
        let alertVC = UIAlertController.logoutAlert()
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    
}

extension ClubIntroDuctionController: UICollectionViewDataSource {
    
    // セクションの総数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // セットするセルの総数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // ClubIntroModelで設定した数だけ取得
        return models.count
    }

    // セルの生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // XIBよりセルを生成
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClubIntroCollectionViewCell", for: indexPath) as! ClubIntroCollectionViewCell
        
        // Modelクラスから取得
        cell.setUpCell(model: models[indexPath.row])
        
        // 画像を取得
        cell.setUpImage(model: models[indexPath.row])
        
        return cell
    }
    
    
    


}

extension ClubIntroDuctionController: UICollectionViewDelegate {
    
    // セルタップイベント
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // タップされたセルのクラブの詳細ページへ遷移
        // パラメータ：「model.clubName」
        //
        let storyboard: UIStoryboard = self.storyboard!
        let clubIntroDetail = storyboard.instantiateViewController(identifier: "ClubIntroductionDetail") as! ClubIntroDuctionDetailViewController
        
        clubIntroDetail.prpClubName = models[indexPath.row].clubName
        self.navigationController?.pushViewController(clubIntroDetail, animated: true)
//        self.present(clubIntroDetail, animated: true, completion: nil)
        
    }
    
    

}

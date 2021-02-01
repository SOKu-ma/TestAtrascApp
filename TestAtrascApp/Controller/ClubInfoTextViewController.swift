//
//  ClubInfoTextViewController.swift
//  TestAtrascApp
//
//  Created by 太田修平 on 2021/01/28.
//

import UIKit

class ClubInfoTextViewController: UIViewController {

    @IBOutlet weak var clubDetailTextView: UITextView!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    var clubDetailText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clubDetailTextView.delegate = self
        
    }
    
    // -- 完了ボタン押下 --
    @IBAction func btnSaveTapped(_ sender: UIBarButtonItem) {
        let sendClubInfoVC = self.presentingViewController as! SendClubInfoViewController
        sendClubInfoVC.clubDetail = self.clubDetailTextView.text
        sendClubInfoVC.isBack = true
        dismiss(animated: true, completion: nil)
    }
    
    // -- キャンセルボタン押下 --
    @IBAction func btnCancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension ClubInfoTextViewController: UITextViewDelegate {
}

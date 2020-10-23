//
//  ClubIntroModel.swift
//  TestAtrascApp
//
//  Created by shuhei ota on 2020/10/23.
//

import Foundation

struct ClubIntroModel {
    
    let clubName: String
    let clubImage: String
    
    static func createModels() -> [ClubIntroModel] {
        
        return [
            ClubIntroModel(clubName: "野球部", clubImage: "baseball"),
            ClubIntroModel(clubName: "ゴルフ部", clubImage: "golf"),
            ClubIntroModel(clubName: "ボウリング部", clubImage: "bowling"),
//            ClubIntroModel(clubName: "ウォータースポーツ部", clubImage: "ggg"),
            ClubIntroModel(clubName: "スキー・スノーボード部", clubImage: "snowboard"),
            ClubIntroModel(clubName: "サッカー・フットサル部", clubImage: "soccer"),
            ClubIntroModel(clubName: "ランニング部", clubImage: "running"),
            ClubIntroModel(clubName: "バスケットボール部", clubImage: "basketball"),
            ClubIntroModel(clubName: "バドミントン部", clubImage: "badminton"),
//            ClubIntroModel(clubName: "釣り部", clubImage: "ggg"),
//            ClubIntroModel(clubName: "カート部", clubImage: "ggg"),
            ClubIntroModel(clubName: "ビリヤード・ダーツ部", clubImage: "billiard"),
            ClubIntroModel(clubName: "卓球部", clubImage: "tabletennis"),
            ClubIntroModel(clubName: "テニス部", clubImage: "tennis"),
        ]
        
    }
}

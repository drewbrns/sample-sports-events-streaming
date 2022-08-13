//
//  AppImage.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 13/08/2022.
//

import UIKit

extension UIImage {

    enum AssetIdentifier: String {
        case placeholder
    }

    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }

}

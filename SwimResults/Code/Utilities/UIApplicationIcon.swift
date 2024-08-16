//
//  BundleIconExtension.swift
//  SwimResults
//
//  Created by Konrad Weiß on 16.08.24.
//

import Foundation
import UIKit

extension UIApplication {
    var icon: String {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? NSDictionary,
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? NSDictionary,
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? NSArray,
            // First will be smallest for the device class, last will be the largest for device class
            let lastIcon = iconFiles.lastObject as? String else {
                return ""
        }

        return lastIcon
    }
}

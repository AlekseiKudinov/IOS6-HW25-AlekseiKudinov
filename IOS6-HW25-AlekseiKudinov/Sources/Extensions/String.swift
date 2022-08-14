//
//  String.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 15.08.2022.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}


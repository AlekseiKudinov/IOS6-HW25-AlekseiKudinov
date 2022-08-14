//
//  Date.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 15.08.2022.
//

import Foundation

extension Date {
    func getCurrentTimestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

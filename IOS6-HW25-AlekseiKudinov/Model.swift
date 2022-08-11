//
//  Model.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 11.08.2022.
//

import Foundation

struct Character: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let image: String?
    let comics: String?
}

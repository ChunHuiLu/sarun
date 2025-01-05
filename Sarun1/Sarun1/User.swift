//
//  User.swift
//  Sarun1
//
//  Created by 卢春晖 on 2025/1/5.
//

import Foundation

/*
 你将能够解码这个 JSON
 {
     "first_name": "John",
     "last_name": "Doe",
     "middle_name": null
 }

 {
     "first_name": "John",
     "last_name": "Doe"
 }
 */
// MARK:  重命名
struct UserName: Codable {
    var firstName: String
    var lastName: String
    var middleName: String?
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
    }
    
}

// MARK: 扁平化 JSON
struct User: Codable {
    var name: String
    var district:String
    var subDistrict:String
    var country:String
    var postalCode:String
    // 您需要定义两个枚举，每个枚举列出在特定级别上使用的完整编码键集。
    enum CodingKeys: CodingKey {
        case name
        case billingAddress
    }
    enum BillingAddress: CodingKey {
        case district
        case subDistrict
        case country
        case postalCode
    }
    init(name: String, district:String, subDistrict:String, country:String, postalCode:String) {
        self.name = name
        self.district = district
        self.subDistrict = subDistrict
        self.country = country
        self.postalCode = postalCode
    }
    // 编码
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        var billingAddress = container.nestedContainer(keyedBy: BillingAddress.self, forKey: .billingAddress)
        try billingAddress.encode(district, forKey: .district)
        try billingAddress.encode(subDistrict, forKey: .subDistrict)
        try billingAddress.encode(country, forKey: .country)
        try billingAddress.encode(postalCode, forKey: .postalCode)
    }
    // 解码
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let billingAddress = try values.nestedContainer(keyedBy: BillingAddress.self, forKey: .billingAddress)
        district = try billingAddress.decode(String.self, forKey: .district)
        subDistrict = try billingAddress.decode(String.self, forKey: .subDistrict)
        country = try billingAddress.decode(String.self, forKey: .country)
        postalCode = try billingAddress.decode(String.self, forKey: .postalCode)
    }
}

// MARK: 嵌套 JSON
struct User1: Codable {
    var name: String
    var billingAddress: BillingAddress
    enum CodingKeys: String, CodingKey {
        case name
        case billingAddress
        case district
        case subDistrict
        case country
        case postalCode
    }
    init(name: String, billingAddress: BillingAddress) {
        self.name = name
        self.billingAddress = billingAddress
    }
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(billingAddress.district, forKey: .district)
        try container.encode(billingAddress.subDistrict, forKey: .subDistrict)
        try container.encode(billingAddress.country, forKey: .country)
        try container.encode(billingAddress.postalCode, forKey: .postalCode)
    }
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        billingAddress = try BillingAddress(from: decoder)
    }
    
}

struct BillingAddress: Codable {
    var district: String
    var subDistrict: String
    var country: String
    var postalCode: String
}

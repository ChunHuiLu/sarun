//
//  ViewController.swift
//  Sarun1
//
//  Created by 卢春晖 on 2025/1/5.
//  https://sarunw.com/posts/codable-in-swift-4/

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 扁平化 JSON
        
        /*
         假设您有User包含嵌套billingAddress属性的 JSON
         {
             "name": "John",
             "billingAddress": {
                 "district": "District",
                 "subDistrict": "Sub District",
                 "country": "Country",
                 "postalCode": "Postal Code"
             }
         }
         您想把它转化为这样的结构体中：
         struct User: Codable {
             var name: String
             var district: String
             var subDistrict: String
             var country: String
             var postalCode: String
         }
         */
//        testFlattenJson()
        
        /*
         与上面相反，我们有这样的json数据
         {
             "name": "John",
             "district": "District",
             "subDistrict": "Sub District",
             "country": "Country",
             "postalCode": "Postal Code"
         }
         想把它转化为这样的结构体中：
         struct User: Codable {
             var name: String
             var billingAddress: BillingAddress
         }

         struct BillingAddress: Codable {
             var district: String
             var subDistrict: String
             var country: String
             var postalCode: String
         }
         */
        
        testNestingJson()
    }
    
    func testFlattenJson() {
        let jsonString = """
    {
        "name": "John",
        "billingAddress": {
            "district": "District",
            "subDistrict": "Sub District",
            "country": "Country",
            "postalCode": "Postal Code"
        }
    }
"""
        guard let jsonData = jsonString.data(using: .utf8) else {return}
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: jsonData)
            print("Decoded User:")
            print("Name: \(user.name)")
            print("District: \(user.district)")
            print("Sub-District: \(user.subDistrict)")
            print("Country: \(user.country)")
            print("Postal Code: \(user.postalCode)")
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func testNestingJson() {
        let jsonString = """
          {
              "name": "John",
              "district": "District",
              "subDistrict": "Sub District",
              "country": "Country",
              "postalCode": "Postal Code"
          }
        """
        guard let jsanData = jsonString.data(using: .utf8) else {return}
        do {
            let decoder = JSONDecoder()
            let user1 = try decoder.decode(User1.self, from: jsanData)
            print("Decoded User:")
            print("Name: \(user1.name)")
            print("billingAddress:")
            print("District: \(user1.billingAddress.district)")
            print("Sub-District: \(user1.billingAddress.subDistrict)")
            print("Country: \(user1.billingAddress.country)")
            print("Postal Code: \(user1.billingAddress.postalCode)")
        } catch {
            print("Error decoding JSON: \(error)")
        }
                
    }
}


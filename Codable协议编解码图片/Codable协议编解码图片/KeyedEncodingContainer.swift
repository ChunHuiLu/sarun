//
//  KeyedEncodingContainer.swift
//  Codable协议编解码图片
//
//  Created by lang on 2025/1/2.
//

import UIKit

extension KeyedEncodingContainer {
    
    mutating func encode(_ value: UIImage,
                         forKey key: KeyedEncodingContainer.Key) throws {
        
        let imageData = value.jpegData(compressionQuality: 1)
        let prefix = "data:image/jpeg;base64,"
        
        guard let base64String = imageData?.base64EncodedString(options: .lineLength64Characters) else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath, debugDescription: "Can't encode image to base64 string."))
        }
        
        try encode(prefix + base64String, forKey: key)
    }
    
}

//
//  KeyedDecodingContainer.swift
//  Codable协议编解码图片
//
//  Created by lang on 2025/1/2.
//

import UIKit

extension KeyedDecodingContainer {
    
    public func decode(_ type: UIImage.Type, forKey key: KeyedDecodingContainer.Key) throws -> UIImage {
        let base64String = try decode(String.self, forKey: key)
        
        // data:image/svg+xml;base64,PD.....
        let components = base64String.split(separator: ",")
    
        if components.count != 2 {
            throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: codingPath, debugDescription: "Unsupported format"))
        }
        
        let dataString = String(components[1])
        if let dataDecoded = Data(base64Encoded: dataString, options: .ignoreUnknownCharacters), let image = UIImage(data: dataDecoded) {
            return image
        } else {
            throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: codingPath, debugDescription: "Unsupported format"))
        }
    }
    
}

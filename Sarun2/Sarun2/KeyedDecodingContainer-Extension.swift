//
//  KeyedDecodingContainer-Extension.swift
//  Sarun2
//
//  Created by 卢春晖 on 2025/1/5.
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
        if let dataDacoded = Data(base64Encoded: dataString, options: .ignoreUnknownCharacters),
           let image = UIImage(data: dataDacoded) {
            return image
        } else {
            throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: codingPath, debugDescription: "Unsupported format"))
        }
        
    }
}

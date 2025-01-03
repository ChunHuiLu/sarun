//
//  ModelUsingKeyedEncodingContainer.swift
//  Codable协议编解码图片
//
//  Created by lang on 2025/1/2.
//

import UIKit


struct ModelUsingKeyedEncodingContainer: Codable {
  let name: String
  let image: UIImage
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
  enum CodingKeys: String, CodingKey {
    case name
    case image
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    image = try container.decode(UIImage.self, forKey: .image)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(image, forKey: .image)
  }
}

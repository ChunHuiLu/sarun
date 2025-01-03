//
//  ViewController.swift
//  Codable协议编解码图片
//
//  Created by lang on 2025/1/2.
//  来自：https://sarunw.com/posts/enum-custom-type-from-primitive-json-type/

import UIKit

struct ModelUsingImageWrapper: Codable {
  let name: String
  let image: Base64ImageWrapper
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "scan_icon")!
        let modelUsingKeyedEncodingContainer = ModelUsingKeyedEncodingContainer(name: "1", image: image)
        //路径
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("imagePath")
        // 写入数据
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(modelUsingKeyedEncodingContainer) else {
            print("无法将用户数据存档")
            return
        }
        do {
            try data.write(to: filePath)
            print("归档成功")
        } catch {
            print("归档失败")
        }
        // 读出数据
        guard let encodeData = try? Data(contentsOf: filePath) else {
            print("无法读取用户的数据")
            return
        }
        do {
            let decoder = JSONDecoder()
            let modelUsing = try decoder.decode(ModelUsingKeyedEncodingContainer.self, from: encodeData)
            print("用户信息解码成功\(modelUsing)")
            self.imageView.image = modelUsing.image
        } catch {
            print("用户信息解码失败")
        }
        
        
    }


}


extension ViewController {
    func adas() {
        struct ModelUsingImageWrapper: Codable {
          let name: String
          let image: Base64ImageWrapper
        }
    }
}

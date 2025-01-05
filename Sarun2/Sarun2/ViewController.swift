//
//  ViewController.swift
//  Sarun2
//
//  Created by 卢春晖 on 2025/1/5.
//  https://sarunw.com/posts/enum-custom-type-from-primitive-json-type/

import UIKit


struct Job: Codable {
    enum Status: String, Codable {
        case open
        case close
    }
    let name: String
    let status: Status
}

struct ModelUsingImageWrapper: Codable {
  let name: String
  let image: Base64ImageWrapper
}

struct ModelUsingKeyedEncodingContainer: Codable {
    let name: String
    let image: UIImage
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    enum CodingKeys:String, CodingKey {
        case name
        case image
    }
    
    // 解码
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(UIImage.self, forKey: .image)
    }
    // 编码
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(image, forKey: .image)
        try container.encode(name, forKey: .name)
    }
    
}
class ViewController: UIViewController {

    @IBOutlet weak var uiimageView: UIImageView!
    
    var filePath: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("filePath/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 枚举的写法1
        let _ = Job(name: "jack", status: .close)
        // 由于 UIImage 不符合 Codable 并且我们无法通过扩展来符合它，因此我们有两种方法来处理这个问题：
        // 方法 1 使用包装器
//        testBase64ImageWrapper()
        // 方法 2 为 UIImage 添加自定义编码/解码：
        customEncodingAndDecoding()
    }
    
    func testBase64ImageWrapper() {
        // 编码
        guard let image = UIImage(named: "fengjing") else {return}
        // 判断文件夹是否存在，不存在就创建
        var isDirectory:ObjCBool = false
        if !FileManager.default.fileExists(atPath: filePath.path, isDirectory: &isDirectory) || !isDirectory.boolValue {
            do {
                try FileManager.default.createDirectory(at: filePath, withIntermediateDirectories: true)
            } catch {
                print("创建fileList目录失败：\(error.localizedDescription)")
                return
            }
        }
        
        
        let modelUsingImageWrapper = ModelUsingImageWrapper(name: "1", image: Base64ImageWrapper(image: image))
        // 编码为json数据
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(modelUsingImageWrapper)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? "Error encoding to JSON"
            print("Encoded JSON:\n\(jsonString)")
            // 写入
            let filePath = filePath.appendingPathComponent(modelUsingImageWrapper.name)
            print("写入路径：" + filePath.path)
            do {
                try jsonData.write(to: filePath)
            } catch {
                print("写入失败：" + filePath.path)
            }
        } catch {
            print("Error encoding: \(error)")
        }
        
        // 解码
        do {
            let filePath = filePath.appendingPathComponent(modelUsingImageWrapper.name)
            let deData = try Data(contentsOf: filePath)
            // 解码json数据
            let decoder = JSONDecoder()
            let decoderModel = try decoder.decode(ModelUsingImageWrapper.self, from: deData)
            print("Decoded Model: \(decoderModel)")
            let deImage = decoderModel.image.image
            uiimageView.image = deImage
        } catch {
            print("Error decoding: \(error)")
        }
        
    }
    
    func customEncodingAndDecoding() {
        guard let image = UIImage(named: "ada") else {return}
        let model = ModelUsingKeyedEncodingContainer(name: "2", image: image)
        // 判断文件夹是否存在，不存在就创建
        var isDirectory:ObjCBool = false
        if !FileManager.default.fileExists(atPath: filePath.path, isDirectory: &isDirectory) || !isDirectory.boolValue {
            do {
                try FileManager.default.createDirectory(at: filePath, withIntermediateDirectories: true)
            } catch {
                print("创建fileList目录失败：\(error.localizedDescription)")
                return
            }
        }
        
        // 编码为json数据
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(model)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? "Error encoding to JSON"
            print("Encoded JSON:\n\(jsonString)")
            // 写入
            let filePath = filePath.appendingPathComponent(model.name)
            print("写入路径：" + filePath.path)
            do {
                try jsonData.write(to: filePath)
            } catch {
                print("写入失败：" + filePath.path)
            }
        } catch {
            print("Error encoding: \(error)")
        }
        
        // 解码
        do {
            let filePath = filePath.appendingPathComponent(model.name)
            let deData = try Data(contentsOf: filePath)
            // 解码json数据
            let decoder = JSONDecoder()
            let decoderModel = try decoder.decode(ModelUsingKeyedEncodingContainer.self, from: deData)
            print("Decoded Model: \(decoderModel)")
            let deImage = decoderModel.image
            uiimageView.image = deImage
        } catch {
            print("Error decoding: \(error)")
        }
    }

}


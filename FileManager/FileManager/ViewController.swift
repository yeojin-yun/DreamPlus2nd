//
//  ViewController.swift
//  FileManager
//
//  Created by 순진이 on 2022/09/22.
//

import UIKit

class FileManagerViewController: UIViewController {
    
    let fileManager = FileManager.default

    @IBAction func didTapSaveButton(_ sender: UIButton) {
        save()
    }
    
    @IBAction func didTapLoadButton(_ sender: UIButton) {
        load()
    }
    func save1() {
            var isDirectory: ObjCBool = true
            if fileManager.fileExists(atPath: getMyAppDirectoryPath().path, isDirectory: &isDirectory) {
                let person = Person(name: "ABC", age: 111)
                do {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: false)
                    do {
                        try data.write(to: getMyAppFilePath())
                        print("파일 쓰기 성공")
                    } catch {
                        print("파일 쓰기 에러: \(error)")
                    }
                } catch {
                    print("아카이브 에러: \(error)")
                }
            } else {
                do {
                    try fileManager.createDirectory(atPath: getMyAppDirectoryPath().path, withIntermediateDirectories: false)
                    print("폴더 생성 완료")
                } catch {
                    print("폴더 생성 실패: \(error)")
                }
            }
        }
}

extension FileManagerViewController {
    
    func save() {
        var isDirectory: ObjCBool = true
        if fileManager.fileExists(atPath: getMyAppDirectoryPath().path, isDirectory: &isDirectory) {
            let someString = "Hello World"
            do {
                try someString.write(to: getMyAppFilePath(), atomically: true, encoding: .utf8)
                print("파일 쓰기 성공")
            } catch {
                print("파일 쓰기 실패: \(error)")
            }
        } else {
            do {
                try fileManager.createDirectory(atPath: getMyAppDirectoryPath().path, withIntermediateDirectories: false)
                print("폴더 생성 완료")
            } catch {
                print("폴더 생성 실패: \(error)")
            }
        }
    }
    
    func load() {
        
    }
}

extension FileManagerViewController {
    
    func getDocumentDirectoryPath() -> URL {
        let documentDirectoryPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectoryPath
    }
    
    func getMyAppDirectoryPath() -> URL {
        let documentDirectoryPath = getDocumentDirectoryPath()
        let myAppDirectoryPath = documentDirectoryPath.appendingPathComponent("My App", isDirectory: true)
        return myAppDirectoryPath
    }
    
    func getMyAppFilePath() -> URL {
        let myAppDirectoryPath = getMyAppDirectoryPath()
        let filePath = myAppDirectoryPath.appendingPathComponent("Test.txt")
        return filePath
    }
}

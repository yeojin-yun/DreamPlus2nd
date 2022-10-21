//
//  FileManagerViewController.swift
//  FileManager
//
//  Created by 순진이 on 2022/10/21.
//

import UIKit

class FileManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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

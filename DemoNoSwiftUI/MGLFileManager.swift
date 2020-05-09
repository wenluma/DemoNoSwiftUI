//
//  MGLFileManager.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/9.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

class MGLFileManager {
    
    // 组名
    private static let groupIdentifer = "group.com.example.documents"
    
    // group 的 url
    private static let shareURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifer)
    
    let fileCoordinator = NSFileCoordinator(filePresenter: nil)

    
    func read(path: String) {
        var error: NSError?
        let fileURL = NSURL.fileURL(withPath: path)
        fileCoordinator.coordinate(readingItemAt: fileURL, options: NSFileCoordinator.ReadingOptions.forUploading, error: &error) { (url) in
            // read content here
        }
    }
    
    func write(path: String) {
        var error: NSError?
        let fileURL = NSURL.fileURL(withPath: path)
        fileCoordinator.coordinate(writingItemAt: fileURL, options: .forDeleting, error: &error) { (url) in
//            write content here
        }
    }
}

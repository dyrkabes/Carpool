//
//  FileDataLoader.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation


public struct FileDataLoader {
    public init() {} 
    
    public func loadFromJSONFile(_ fileName: String, bundle: Bundle = Bundle.main) -> Data? {
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        
        return data
    }
}

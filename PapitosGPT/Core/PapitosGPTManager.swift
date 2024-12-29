//
//  PapitosGPTManager.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 27/12/24.
//

import Foundation

struct PapitosGPTManager {
    static func getAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "PapitosGPT", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: path) as? [String: Any] {
            return plist["OPENAI_API_KEY"] as? String
        }
        return nil
    }
}

//
//  Logger.swift
//  SwiftDebug
//
//  Created by DianQK on 16/1/26.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import XCGLogger

public let log: XCGLogger = {
    let log = XCGLogger.defaultInstance()
    let logPath : NSURL = cacheDirectory.URLByAppendingPathComponent("XCGLogger.Log")
    // By using Swift build flags, different log levels can be used in debugging versus staging/production. Go to Build settings -> Swift Compiler - Custom Flags -> Other Swift Flags and add -DDEBUG to the Debug entry.
    #if DEBUG
        log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil)
    #else
        log.setup(.Severe, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil)
    #endif
    log.xcodeColorsEnabled = true
    log.xcodeColors = [
        .Verbose: .lightGrey,
        .Debug: .darkGrey,
        .Info: .darkGreen,
        .Warning: .orange,
        .Error: .red,
        .Severe: .whiteOnRed
    ]
    return log
}()

public struct NetworkLog {
    static let ESCAPE = "\u{001b}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    typealias StatusCode = Int
    static func out(statusCode: StatusCode, target: (baseURL: NSURL, path: String, method: String, parameters: [String: AnyObject]?), json: AnyObject) {
        var codeColor = "fg255,0,0"
        if statusCode == 200 {
            codeColor = "fg0,255,0"
        }
        print("\(ESCAPE)\(codeColor);\(statusCode)\(RESET) \(ESCAPE)fg53,255,206;\(target.method)\(RESET) \(ESCAPE)fg69,69,69;\(target.baseURL)\(target.path) \(target.parameters ?? [:])\(RESET) \n\(ESCAPE)fg29,29,29;\(json)\(RESET)")
    }
}

private var documentsDirectory: NSURL {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.endIndex-1]
}

private var cacheDirectory: NSURL {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
    return urls[urls.endIndex-1]
}
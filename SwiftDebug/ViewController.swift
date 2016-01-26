//
//  ViewController.swift
//  SwiftDebug
//
//  Created by 宋宋 on 16/1/26.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        log.verbose("This is Verbose.")
        log.debug("This is Debug.")
        log.info("This is Info.")
        log.warning("This is Warning.")
        log.error("This is Error.")
        log.severe("This is Servre.")
        NetworkLog.out(200, target: (baseURL: NSURL(string: "http://swift.gg")!, path: "/v5", method: "GET", parameters: ["article": 1]), json: ["title":"结构体中的 Lazy 属性探究", "author":"Ole Begemann", "translator":"pmst","content":"666666"])
        NetworkLog.out(404, target: (baseURL: NSURL(string: "http://swift.gg")!, path: "/v5", method: "GET", parameters: ["article": 0]), json: ["error":"not exist."])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


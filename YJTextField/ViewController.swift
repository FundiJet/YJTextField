//
//  ViewController.swift
//  YJTextField
//
//  Created by Jet on 16/9/6.
//  Copyright © 2016年 Jet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let tf = YJTextField()
        tf.frame = CGRectMake(0, 0, 200, 40)
        tf.placeholder = "Please input"
        tf.center = view.center
        tf.placeholderSelectColor = UIColor.whiteColor()
        view.addSubview(tf)
        
        view.backgroundColor = UIColor.brownColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


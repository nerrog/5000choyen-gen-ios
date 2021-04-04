//
//  aboutappViewController.swift
//  5000choyen-gen
//
//  Created by tnk on 2021/04/04.
//

import UIKit

class aboutappViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func tw(_ sender: Any) {
        openlink(link: "https://twitter.com/nerrog_blog")
    }
    
    @IBAction func github(_ sender: Any) {
        openlink(link: "http://github.com/nerrog/5000choyen-gen-ios")
    }
    @IBAction func useapi(_ sender: Any) {
        openlink(link: "http://github.com/CyberRex0/5000choyen-api#readme")
    }
}
    
    
    
func openlink (link:String){
        let url = URL(string:link)!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
    }
}


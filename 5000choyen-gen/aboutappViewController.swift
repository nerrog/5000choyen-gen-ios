//
//  aboutappViewController.swift
//  5000choyen-gen
//
//  Created by tnk on 2021/04/04.
//

import UIKit

class aboutappViewController: UIViewController {

    let delegate = UIApplication.shared.delegate as! AppDelegate
    
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
    
    @IBAction func Close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true,completion: nil)
    }
    
    @IBAction func changeApi(_ sender: UIButton) {
        //APIのエンドポイント変更
        var alertTextField: UITextField?

        let alert = UIAlertController(
            title: "5000choyen-apiのエンドポイントを指定してください",
            message: "推奨: https://gsapi.cbrx.io/image",
            preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(
            configurationHandler: {(textField: UITextField!) in
                alertTextField = textField
                textField.text = (self.delegate.userDefaults.object(forKey: "GSAPI_ENDPOINT") as! String)
        })
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: UIAlertAction.Style.cancel,
                handler: nil))
        alert.addAction(
            UIAlertAction(
                title: "デフォルトに戻す",
                style: UIAlertAction.Style.destructive) {_ in
                    self.delegate.userDefaults.set("https://gsapi.cbrx.io/image", forKey: "GSAPI_ENDPOINT")
                })
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default) { _ in
                if let text = alertTextField?.text {
                    //OK処理
                    self.delegate.userDefaults.set(text, forKey: "GSAPI_ENDPOINT")
                }
            }
        )

        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func openlink (link:String){
            let url = URL(string:link)!
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
        }
}
    
    
    

}


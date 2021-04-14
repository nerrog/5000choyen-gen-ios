//
//  ViewController.swift
//  5000choyen-gen
//
//  Created by tnk on 2021/04/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toptxt: UITextField!
    @IBOutlet weak var bottomtxt: UITextField!
    @IBOutlet weak var gen_img: UIImageView!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var donebtn: UIBarButtonItem!
    @IBOutlet weak var rainbow: UISwitch!
    @IBOutlet weak var hoshii: UISwitch!
    @IBOutlet weak var single: UISwitch!
    @IBOutlet var keyboardbar: UIToolbar!
    
    var alertController: UIAlertController!
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //ToolBarの高さを機種ごとに変える
        let width = UIScreen.main.bounds.size.width
                let height = UIScreen.main.bounds.size.height
                //iPhoneX系
                if height > 800.0 && height < 1000.0{
                    toolbar.frame = CGRect(x: 0, y: height * 0.92, width: width, height: height * 0.055)
                }
        toptxt.inputAccessoryView = keyboardbar
        bottomtxt.inputAccessoryView = keyboardbar
        gen_img.isUserInteractionEnabled = true
    }
    

    @IBAction func gen(_ sender: Any) {
        toptxt.endEditing(true)
        bottomtxt.endEditing(true)
        var apiurl = "https://gsapi.cyberrex.ml/image"
        let top:String = toptxt.text!;
        let btm:String = bottomtxt.text!;
        
        //APIの仕様に合わせて条件分岐でurlのパラメーターを変える
        if (top == ""){
            if(btm == ""){
                //両方が空なのでエラー
                alert(title: "エラー",
                              message: "上部・下部文字列両方を空にすることはできません。")
                return;
            }else if (single.isOn){
                //topが空でbottomに値が入ってかつ、singleの場合
                apiurl += "?bottom="+btm+"&single=true";
            }else{
                //bottomだけでsingleもなしだとエラー
                alert(title: "エラー",
                              message: "singleオプションなしで下部文字列だけを指定することはできません。")
                return;
            }
        }else if (btm != ""){
            //両方の値が入っている
            apiurl += "?top="+top+"&bottom="+btm;
        }else if (single.isOn == true){
            //bottom空、singleの場合
            apiurl += "?top="+top+"&single=true";
        }else{
            //topだけでsingleなし、エラー
            alert(title: "エラー",
                          message: "singleオプションなしで上部文字列だけを指定することはできません。")
            return;
        }
        //single以外のオプションの実装
        if (hoshii.isOn == true){
            apiurl += "&hoshii=true";
        }
        if (rainbow.isOn == true){
            apiurl += "&rainbow=true";
        }
        
        let encodeUrlString: String = apiurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodeUrlString)
        do {
                    let data = try Data(contentsOf: url!)
                    image = UIImage(data: data)!
                    gen_img.image = image;
                    gen_img.alpha = 1
                    share.isEnabled = true;
                    
                    

               }catch let err {
                alert(title: "APIエラー",
                              message: "APIエラーが発生しました\n時間を置いて再度お試しください。\n \(err.localizedDescription)")
               }
        
    }

    @IBAction func share(_ sender: UITabBarItem) {
        shareimg()
            }
    
    
    @IBAction func longpress(_ sender: UILongPressGestureRecognizer) {
        
        shareimg()
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        let ac = UIAlertController(title: "警告", message: "本当に内容をクリアしますか?", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.toptxt.text = ""
            self.bottomtxt.text = ""
        }))
        ac.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    //共有モーダルを表示する
    func shareimg(){
        if share.isEnabled == true{
            let gen = UINotificationFeedbackGenerator()
            gen.notificationOccurred(.success)
            let shareItems = [image]
                    
            let avc = UIActivityViewController(activityItems: shareItems as [Any], applicationActivities: nil)
            //この2行を入れないとiPadでは落ちる
            avc.popoverPresentationController?.sourceView = self.view;
            avc.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0);
            
                    // 使用しないアクティビティタイプ
                    let excludedActivityTypes = [
                        UIActivity.ActivityType.postToWeibo,
                        //UIActivity.ActivityType.airDrop,
                        UIActivity.ActivityType.assignToContact,
                        UIActivity.ActivityType.addToReadingList,
                        UIActivity.ActivityType.mail,
                        UIActivity.ActivityType.message
                    ]
                    avc.excludedActivityTypes = excludedActivityTypes
                    
                    present(avc, animated: true, completion: nil)
            }
    }
    //ダイアログ表示用関数
    func alert(title:String, message:String) {
            alertController = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
            present(alertController, animated: true)
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func done(_ sender: Any) {
        self.view.endEditing(true)
    }
    

}

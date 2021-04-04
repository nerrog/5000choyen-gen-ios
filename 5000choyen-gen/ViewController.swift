//
//  ViewController.swift
//  5000choyen-gen
//
//  Created by tnk on 2021/04/02.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var toptxt: UITextField!
    @IBOutlet weak var bottomtxt: UITextField!
    @IBOutlet weak var gen_img: UIImageView!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var rainbow: UISwitch!
    @IBOutlet weak var hoshii: UISwitch!
    @IBOutlet weak var single: UISwitch!
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //グラデーション用
        //グラデーションの開始色
        let topColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        //グラデーションの開始色
        let bottomColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)

        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]

        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()

        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.view.bounds

        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    

    @IBAction func gen(_ sender: Any) {
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
                    let image = UIImage(data: data)
                    gen_img.image = image;
                    share.isEnabled = true;
                    

               }catch let err {
                alert(title: "APIエラー",
                              message: "APIエラーが発生しました\n時間を置いて再度お試しください。\n \(err.localizedDescription)")
               }
        
    }

    @IBAction func share(_ sender: UIBarButtonItem) {
        //共有モーダルを表示する
        let image = gen_img.image;
        let shareItems = [image]
                
        let avc = UIActivityViewController(activityItems: shareItems as [Any], applicationActivities: nil)
                
                // 使用しないアクティビティタイプ
                let excludedActivityTypes = [
                    UIActivity.ActivityType.postToWeibo,
                    UIActivity.ActivityType.airDrop,
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.mail,
                    UIActivity.ActivityType.message
                ]
                avc.excludedActivityTypes = excludedActivityTypes
                
                present(avc, animated: true, completion: nil)
        
                //評価をお願いする
                SKStoreReviewController.requestReview()
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
    
    //このAppについてのリンク
    




}

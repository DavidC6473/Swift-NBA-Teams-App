//
//  WebViewController.swift
//  IOS_A1_XML
//
//  Created by David Clarke on 16/03/2022.
//

import UIKit
import WebKit
import CoreData

class WebViewController: UIViewController, WKNavigationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pEntity : NSEntityDescription! = nil
    var pManageObject : CoreDataEntity! =  nil
    
    var teamData : Team!
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        if pManageObject != nil{
            let url = URL(string: pManageObject.webteam ?? "https://www.nba.com")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
            
        }
    }
}

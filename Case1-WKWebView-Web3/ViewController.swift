//
//  ViewController.swift
//  app
//
//  Created by Patricia on 11/02/2020.
//  Copyright © 2020 IWEB. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

let MessageHandler = "didFetchValue"

class ViewController: UIViewController {
    
    var webView: WKWebView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var lessButton: UIButton!

    var script: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
               
        let config = WKWebViewConfiguration()
        
        let contentController = WKUserContentController()
        
        let web3ScriptPath = Bundle.main.path(forResource: "packedWeb3", ofType: "js", inDirectory: "JavascriptCode")
        let web3ScriptString = try! String(contentsOfFile: web3ScriptPath!, encoding: .utf8)
        let web3FetchValueScript = WKUserScript(source: web3ScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(web3FetchValueScript)
        print("Web3 importado")
        
        let abiScriptPath = Bundle.main.path(forResource: "contractAbi", ofType: "js", inDirectory: "JavascriptCode")
        let abiScriptString = try! String(contentsOfFile: abiScriptPath!, encoding: .utf8)
        let abiFetchValueScript = WKUserScript(source: abiScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(abiFetchValueScript)
        print("Abi importado")

        contentController.add(self, name: MessageHandler)
        config.userContentController = contentController
        
        self.webView = WKWebView(frame: CGRect.init(), configuration: config)
        
        let scriptPath = Bundle.main.path(forResource: "app", ofType: "js", inDirectory: "JavascriptCode")!
        self.script = try! String(contentsOfFile: scriptPath, encoding: .utf8)
        self.webView.load(URLRequest(url: URL(fileURLWithPath: scriptPath)))
        
        print("¿Cargando app.js?")
        print(self.webView.isLoading ? "Sí. Hay que esperar" : "Ya he terminado!")
        while (self.webView.isLoading) {
            CFRunLoopRunInMode(CFRunLoopMode.defaultMode, 0.1, false)
        }
        print(self.webView.isLoading ? "Sí. Hay que esperar" : "Ya he terminado!")
        
        self.webView.evaluateJavaScript(self.script+"getContract()", completionHandler: nil)
        self.webView.evaluateJavaScript(self.script+"getAccount()", completionHandler: nil)
        
        print("")
        self.webView.evaluateJavaScript(self.script+"getValor()", completionHandler: nil)
        
    }
    
    
    @IBAction func incr(_ sender: UIButton) {
        print("Incrementar valor")
        self.webView.evaluateJavaScript(self.script+"incr()", completionHandler: nil)
    }
    
    @IBAction func decr(_ sender: UIButton) {
        print("Decrementar valor")
        self.webView.evaluateJavaScript(self.script+"decr()", completionHandler: nil)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        print("Restablecer valor")
        self.webView.evaluateJavaScript(self.script+"reset()", completionHandler: nil)
    }
    
}

// https://medium.com/@JillevdWeerd/creating-links-between-wkwebview-and-native-code-8e998889b503

extension ViewController: WKScriptMessageHandler, WKNavigationDelegate {

  
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //This function handles the events coming from javascript. We'll configure the javascript side of this later.
        //We can access properties through the message body, like this:
        print(message.body)
        // Get the last character of the message, which contains the value
        let body = message.body as! String
        let valueChar = body.last!
        let valueString = String(valueChar)
        self.label.text = valueString

        // Para mandar varios paramteros y recogerlos
        // https://medium.com/john-lewis-software-engineering/ios-wkwebview-communication-using-javascript-and-swift-ee077e0127eb
    }

}


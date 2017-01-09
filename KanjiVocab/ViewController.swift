//
//  ViewController.swift
//  KanjiVocab
//
//  Created by Jonathan Clarke on 06/01/2017.
//  Copyright © 2017 Jonathan Clarke. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var triplet : Triplet?
    var indexes : [Int] = []
    
    @IBOutlet weak var lblKanji: UILabel!
    @IBOutlet weak var btnHiragana: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kanji Vocab"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.clickAdd) )
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.clickShare))
        print( Vocab.sharedInstance )
        doShuffle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickAdd()
    {
        EditVC.loadVC( sb: self.storyboard!, nc: self.navigationController! )
    }
    
    func showCurrent() {
        if let t = triplet {
            lblKanji.text = t.kanji
            btnHiragana.setTitle("Hiragana", for: .normal)
            btnEnglish.setTitle("English", for: .normal)
        }
    }
    
    func clickShare() {
        let text = Vocab.sharedInstance.makeContents()
        sendEmail(text: text)
    }
    
    func sendEmail(text: String) {
        if MFMailComposeViewController.canSendMail() {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Kanji Vocab at " + df.string(from: Date() ) )
            mail.setMessageBody(text, isHTML: false)
            
            present(mail, animated: true, completion: nil)
        } else {
            UIFuncs.showMessage(self, "Error", "Failed to send e-mail")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
//    private func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
//        controller.dismiss(animated: true, completion: nil)
//    }

    @IBAction func clickEnglish(_ sender: Any) {
        if let t = triplet {
            btnEnglish.setTitle(t.english, for: .normal)
        }
    }
    @IBAction func clickHiragana(_ sender: Any) {
        if let t = triplet {
            btnHiragana.setTitle(t.hiragana, for: .normal)
        }
    }
    @IBOutlet weak var clickShuffle: UIButton!
    @IBAction func clickNext(_ sender: Any) {
        if indexes.count == 0 {
            doShuffle()
        } else {
            showFirst()
        }
    }

    @IBAction func clickShuffle(_ sender: Any) {
        doShuffle()
    }
    
    func doShuffle()
    {
        if Vocab.sharedInstance.triplets.count == 0 {
            return
        }
        indexes = []
        struct pair {
            var i : Int
            var guid : String
            init( i : Int, guid : String ) {
                self.i = i
                self.guid = guid
            }
        }
        var pairs : [pair] = []
        for i in 0 ..< Vocab.sharedInstance.triplets.count {
            pairs.append( pair( i : i, guid : NSUUID().uuidString ) )
        }
        indexes = pairs.sorted { $0.guid < $1.guid }.map { $0.i }
        showFirst()
    }
    
    func showFirst()
    {
        if indexes.count == 0 {
            return
        }
        let idx = indexes.remove(at: 0)
        triplet = Vocab.sharedInstance.triplets[ idx ]
        print( idx, indexes, triplet?.makeString())
        showCurrent()
    }
}


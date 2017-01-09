//
//  ViewController.swift
//  KanjiVocab
//
//  Created by Jonathan Clarke on 06/01/2017.
//  Copyright © 2017 Jonathan Clarke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var triplet : Triplet?
    var indexes : [Int] = []
    
    @IBOutlet weak var lblKanji: UILabel!
    @IBOutlet weak var btnHiragana: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kanji Vocab"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.clickAdd) )
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


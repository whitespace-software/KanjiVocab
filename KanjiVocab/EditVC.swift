//
//  EditVC.swift
//  KanjiVocab
//
//  Created by Jonathan Clarke on 06/01/2017.
//  Copyright © 2017 Jonathan Clarke. All rights reserved.
//

import UIKit

class EditVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var txtKanji: UITextField!
    @IBOutlet weak var txtHiragana: UITextField!
    @IBOutlet weak var txtEnglish: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let badColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
    let okColor = UIColor.white
    
    static func loadVC( sb : UIStoryboard, nc : UINavigationController )
    {
        if let vc = sb.instantiateViewController(withIdentifier: "EditVC") as? EditVC {
            nc.pushViewController( vc, animated: true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellID = TripleCell.getReuseIdentifier()
        let nib = UINib(nibName: cellID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //tableView.separatorStyle = .none
        
        title = "Edit"
        tableView.dataSource = self
        txtKanji.addTarget(self, action: #selector(self.changedKanji), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Vocab.sharedInstance.triplets.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TripleCell.getReuseIdentifier(), for: indexPath) as! TripleCell
        let triplet = Vocab.sharedInstance.triplets.reversed()[ indexPath.row ]
        cell.display(triplet: triplet)
        return cell
    }
    
    /*
        let cell = UITableViewCell()
        let t = Vocab.sharedInstance.triplets.reversed()[ indexPath.row ]
        // cell.detailTextLabel?.text = t.hiragana + " " + t.english
        cell.textLabel?.text = t.kanji + " " + t.hiragana + " " + t.english
        // cell.textLabel?.textColor = UIFuncs.getTextColor( revise: t.isRevise() )
        cell.textLabel?.backgroundColor = UIFuncs.getBackgroundColor( revise: t.isRevise() )
        return cell
    }
    */
    func changedKanji()
    {
        guard let val = txtKanji.text else {
            return
        }
        var sgmts : [String] = []
        sgmts.append( val )
        for c in val.characters  {
            sgmts.append(c.description)
            for code in String(c).utf8 {
                sgmts.append( code.description )
            }
        }
        let isHiragana = isPureHiragana(val :val)
        print(  isHiragana.description, sgmts.joined(separator: " ") )
        if isHiragana {
            txtHiragana.text = val
        }
    }
    
    func isPureHiragana( val : String ) -> Bool
    {
        for c in val.characters  {
            var idx = 0
            for code in String(c).utf8 {
                if idx == 0 && ( code.description as NSString ).integerValue != 227 {
                    return false
                }
                idx += 1
            }
        }
        return true
    }
    
    @IBAction func clickSave(_ sender: Any) {
        guard let kanji = txtKanji.text?.trimmingCharacters(in: .whitespacesAndNewlines),
        let hiragana = txtHiragana.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let english = txtEnglish.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                return
        }

        txtKanji.backgroundColor = ( kanji == "" ? badColor : okColor )
        txtHiragana.backgroundColor = ( hiragana == "" ? badColor : okColor )
        txtEnglish.backgroundColor = ( english == "" ? badColor : okColor )
        
        if kanji == "" || hiragana == "" || english == "" {
            return
        }
        Vocab.sharedInstance.add(kanji: kanji, hiragana: hiragana, english: english )
        title = Vocab.sharedInstance.description
        
        txtKanji.text = ""
        txtHiragana.text = ""
        txtEnglish.text = ""
        
        tableView.reloadData()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

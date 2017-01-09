//
//  UIFuncs.swift
//  KanjiVocab
//
//  Created by Jonathan Clarke on 09/01/2017.
//  Copyright © 2017 Jonathan Clarke. All rights reserved.
//

import UIKit

class UIFuncs
{
    static func showMessage( _ vc : UIViewController, _ title : String, _ message : String )
    {
        let c = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert )
        c.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        vc.present(c, animated: false, completion: nil)
    }
    
    static func getTextColor( revise : Bool ) -> UIColor {
        return revise ? UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0) : UIColor.black
    }
    static func getBackgroundColor( revise : Bool ) -> UIColor {
        return revise ? UIColor.yellow : UIColor.white
    }
}

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
}

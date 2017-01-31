//
//  Triplet.swift
//  KanjiVocab
//
//  Created by Jonathan Clarke on 31/01/2017.
//  Copyright © 2017 Jonathan Clarke. All rights reserved.
//

import Foundation

public class Triplet
{
    var kanji : String
    var hiragana : String
    var english : String
    var revise : String
    
    init(kanji : String,hiragana : String,english : String, revise : String = "")
    {
        self.kanji = kanji
        self.hiragana = hiragana
        self.english = english
        self.revise = revise
    }
    func makeString() -> String {
        return [ kanji, hiragana, english, revise ].joined(separator: "|")
    }
    func isRevise() -> Bool {
        return revise == "Y"
    }
    func setRevise( onoff : Bool ) {
        revise = onoff ? "Y" : ""
    }
    func toggleRevise() {
        setRevise(onoff: !isRevise() )
    }
    func matches( searchText : String ) -> Bool {
        return kanji.contains( searchText ) || hiragana.contains( searchText ) || english.lowercased().contains( searchText.lowercased() )
    }
    static func parse( str : String ) -> Triplet?
    {
        let sgmts = str.components(separatedBy: "|")
        if sgmts.count < 3 {
            return nil
        }
        let kanji = sgmts[0].trimmingCharacters(in: .whitespaces)
        let hiragana = sgmts[1].trimmingCharacters(in: .whitespaces)
        let english = sgmts[2].trimmingCharacters(in: .whitespaces)
        if kanji == "" || hiragana == "" || english == "" {
            return nil
        }
        let revise = sgmts.count < 4 ? "" : sgmts[3].trimmingCharacters(in: .whitespaces)
        return Triplet(kanji: kanji, hiragana: hiragana, english: english, revise : revise )
    }
}

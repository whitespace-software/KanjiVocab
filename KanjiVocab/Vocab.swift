//
//  Vocab.swift
//  KanjiVocab
//
//  Created by Jonathan Clarke on 06/01/2017.
//  Copyright © 2017 Jonathan Clarke. All rights reserved.
//

import Foundation


public class Vocab : CustomStringConvertible
{
    static let sharedInstance = Vocab()
    var triplets : [Triplet] = []
    var FILENAME = "Vocab"
    
    init()
    {
        read()
    }
    
    public func add( kanji : String, hiragana : String, english : String )
    {
        let t = Triplet(kanji:kanji, hiragana: hiragana, english:english )
        triplets.append(t)
        write( writeString: makeContents() )
    }
    public func makeContents() -> String {
        let lines = triplets.map { $0.makeString() }
        return lines.joined(separator: "\n")
    }
    public var description: String {
        get {
            return "\(triplets.count) triplets"
        }
    }
    
    func save()
    {
        write( writeString: makeContents() )
    }
    
    public func read()
    {
        let fileURL = getFileURL()
        var readString = "" // Used to store the file contents
        do {
            readString = try String(contentsOf: fileURL )
            // print("File Text: \(readString)")
            let lines = readString.components(separatedBy: "\n")
            triplets = []
            for var line in lines {
                if let t = Triplet.parse(str: line) {
                    triplets.append(t)
                }
            }
            
            
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
    public func write( writeString : String )
    {
        let fileURL = getFileURL()
        do {
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            print( "\(fileURL) written")
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
    private func getFileURL() -> URL {
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return DocumentDirURL.appendingPathComponent(FILENAME).appendingPathExtension("txt")
    }
    
    private func getWriteableDirectory() -> String
    {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
}

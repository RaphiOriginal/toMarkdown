//
//  main.swift
//  Markdown
//
//  Created by Raphael Brunner on 06.04.17.
//  Copyright © 2017 Raphael Brunner. All rights reserved.
//

import Foundation

func printHelp() {
    print("Use this to convert a CSV-File to a Markdown syntax\n\n")
    print("\t-t --title\tfirst line as headerline")
    print("\t-h --help\tprint out helper page")
}

func convertToMarkdown(file inputfile:String, hasHeader header:Bool) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let path = dir.appendingPathComponent(inputfile)
        do{
            let content = try String(contentsOf:path, encoding: String.Encoding.utf8)
            let lines = content.components(separatedBy: .newlines)
            var counter = 0
            for line in lines {
                if !line.isEmpty {
                    var pipe = "|"
                    if(counter == 0 && header){
                        pipe = "||"
                    }
                    let convertedLine = line.replacingOccurrences(of: ";", with: pipe)
                    counter += 1
                    print(pipe + convertedLine + pipe)
                }
            }
            
        } catch {
            print("Failed reading file: " + path.description)
        }
    }
}

var printHeader:Bool = false
var help:Bool = false
var skip:Bool = true

for argument in CommandLine.arguments {
    if(!help && !skip) {
        switch argument {
            case "--help", "-h":
                help = true
                printHelp()
            case "--title", "-t":
                printHeader = true
            default:
                convertToMarkdown(file: argument, hasHeader: printHeader)
        }
    } else {
        skip = false
    }
}

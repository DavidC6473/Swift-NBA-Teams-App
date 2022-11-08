//
//  XMLPeopleParser.swift
//  Assignment 2
//
//  Created by David Clarke on 17/04/2022.
//

import Foundation

class XMLPeopleParser : NSObject, XMLParserDelegate{
    var fileName: String
    init(fileName:String){self.fileName = fileName}
    
    var pName, pAbreviation, pCity, pConference, pDivision, pLogo, pStadium, pStadimage, pWebteam, pWebroster, pPlayer, pPlayerimage, pPosition, pDob, pHeight, pDraft, pPlayerweb : String!
    
    var elementID = -1
    var passData = false
    var team = Team()
    var nba = [Team]()
    
    var parser = XMLParser()
    var tags = ["name", "abreviation", "city", "conference", "division", "logo", "stadium", "stadimage", "webteam", "webroster", "player", "playerimage", "position", "dob", "height", "draft", "playerweb"]
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if(tags.contains(elementName)){
            passData = true
            switch(elementName){
                case"name"          : elementID = 0
                case"abreviation"   : elementID = 1
                case"city"          : elementID = 2
                case"conference"    : elementID = 3
                case"division"      : elementID = 4
                case"logo"          : elementID = 5
                case"stadium"       : elementID = 6
                case"stadimage"     : elementID = 7
                case"webteam"       : elementID = 8
                case"webroster"     : elementID = 9
                case"player"        : elementID = 10
                case"playerimage"   : elementID = 11
                case"position"      : elementID = 12
                case"dob"           : elementID = 13
                case"height"        : elementID = 14
                case"draft"         : elementID = 15
                case"playerweb"     : elementID = 16
                default             : break
            }
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if passData{
            switch elementID {
                case 0 : pName          = string
                case 1 : pAbreviation   = string
                case 2 : pCity          = string
                case 3 : pConference    = string
                case 4 : pDivision      = string
                case 5 : pLogo          = string
                case 6 : pStadium       = string
                case 7 : pStadimage     = string
                case 8 : pWebteam       = string
                case 9 : pWebroster     = string
                case 10 : pPlayer       = string
                case 11 : pPlayerimage  = string
                case 12 : pPosition     = string
                case 13 : pDob          = string
                case 14 : pHeight       = string
                case 15 : pDraft        = string
                case 16 : pPlayerweb    = string
                default: break
            }
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if tags.contains(elementName){
            passData = false
            elementID = -1
        }
        if elementName == "team"{
            team = Team(name: pName, abreviation: pAbreviation, city: pCity, conference: pConference, division: pDivision, logo: pLogo, stadium: pStadium, stadimage: pStadimage, webteam: pWebteam, webroster: pWebroster, player: pPlayer, playerimage: pPlayerimage, position: pPosition, dob: pDob, height: pHeight, draft: pDraft, playerweb: pPlayerweb)
            nba.append(team)
        }
    }
    func parsing(){
        let bundleUrl = Bundle.main.bundleURL
        let fileUrl = URL(string: self.fileName, relativeTo: bundleUrl)
        parser = XMLParser(contentsOf: fileUrl!)!
        parser.delegate = self
        parser.parse()
    }
}

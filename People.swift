//
//  People.swift
//  Assignment 2
//
//  Created by David Clarke on 17/04/2022.
//

import Foundation

class Nba {
    var nbaData : [Team] 
    init() {
        nbaData = [
            Team(name: "Atlanta Hawks", abreviation: "ATL", city: "Atlanta, Georgia", conference: "East", division: "Southeast", logo: "Hawks.png", stadium: "State Farm Arena", stadimage: "hawksstad.jpeg", webteam: "https://www.nba.com/hawks/", webroster: "https://www.nba.com/hawks/", player: "Trae Young", playerimage: "trae.png", position: "Guard", dob: "19 Sep 1998", height: "6'1", draft: "#5 2018", playerweb: "https://en.wikipedia.org/wiki/Trae_Young"),
        ]
    }
    init(xmlFileName: String){
        let parser = XMLPeopleParser(fileName: xmlFileName)
        parser.parsing()
        nbaData = parser.nba
    }
    func count()->Int {return nbaData.count}
    func teamData(index:Int)->Team {return nbaData[index]}
}

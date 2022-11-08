//
//  Person.swift
//  Assignment 2
//
//  Created by David Clarke on 17/04/2022.
//

import Foundation

class Team {
    var name        : String
    var abreviation : String
    var city        : String
    var conference  : String
    var division    : String
    var logo        : String
    var stadium     : String
    var stadimage   : String
    var webteam     : String
    var webroster   : String
    var player      : String
    var playerimage : String
    var position    : String
    var dob         : String
    var height      : String
    var playerweb   : String
    var draft       : String
    
    init () {
            self.name           = ""
            self.abreviation    = ""
            self.city           = ""
            self.conference     = ""
            self.division       = ""
            self.logo           = ""
            self.stadium        = ""
            self.stadimage      = ""
            self.webteam        = ""
            self.webroster      = ""
            self.player         = ""
            self.playerimage    = ""
            self.position       = ""
            self.dob            = ""
            self.height         = ""
            self.playerweb      = ""
            self.draft          = ""
        }
    
    init (name:String, abreviation:String, city:String, conference: String, division:String, logo:String, stadium:String, stadimage:String, webteam:String, webroster:String, player:String, playerimage:String, position:String, dob:String, height:String, draft:String, playerweb:String) {
        self.name           = name
        self.abreviation    = abreviation
        self.city           = city
        self.conference     = conference
        self.division       = division
        self.logo           = logo
        self.stadium        = stadium
        self.stadimage      = stadimage
        self.webteam        = webteam
        self.webroster      = webroster
        self.player         = player
        self.playerimage    = playerimage
        self.position       = position
        self.dob            = dob
        self.height         = height
        self.draft          = draft
        self.playerweb      = playerweb
    }
}

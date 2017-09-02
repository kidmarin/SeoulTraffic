//
//  MapDetails.swift
//  SeoulTraffic
//
//  Created by 강 성민 on 2017. 7. 8..
//  Copyright © 2017년 AppSpace All rights reserved.
//

import UIKit

class MapDetails: NSObject {
    var baseUrl: NSString = ""
    var mapUri: NSString
    var roadUri: NSString
    
    init(mapUri: NSString, roadUri: NSString) {
        self.mapUri = mapUri
        self.roadUri = roadUri
    }
    
    // MARK: Public Methods
    public func mapUrl() -> String {
        return "\(baseUrl)\(mapUri)"
    }
    
    public func roadUrl() -> String {
        return "\(baseUrl)\(roadUri)"
    }
    
    // MARK: Preset Methods
    static public func nationalMap() -> MapDetails {
        return MapDetails(mapUri: "/national.png", roadUri: "/national.gif")
    }
    
    static public func expressMap() -> MapDetails {
        return MapDetails(mapUri: "/express.png", roadUri: "/express.gif")
    }
    
    static public func namsanMap() -> MapDetails {
        return MapDetails(mapUri: "/namsan.png", roadUri: "/namsan.gif")
    }
}

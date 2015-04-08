//
//  UdacityDataManager.swift
//  Wedu
//
//  Created by Vik Denic on 4/7/15.
//  Copyright (c) 2015 Nektar Labs. All rights reserved.
//

import Foundation
import Alamofire

let kUdacityResourceURL = "https://udacity.com/public-api/v0/courses"

enum EdXTrackType : Int
{
    case DataScience
    case WebDevelopment
    case SoftwareEngineering
    case iOS
    case GeorgiaTechMastersinCS
    case NonTechClasses

    func text() -> String! {
        switch self {
        case DataScience: return "Data Science"
        case WebDevelopment: return "Web Development"
        case SoftwareEngineering: return "Software Engineering"
        case iOS: return "iOS"
        case GeorgiaTechMastersinCS: return "Georgia Tech Masters in CS"
        case NonTechClasses: return "Non-Tech Classes"
        }
    }
}

class UdacityDataManager {

    class func queryAllCourses(completed : (courses : [AnyObject]) -> Void)
    {
        Alamofire.request(.GET, kUdacityResourceURL).responseJSON() {
            (_, _, data, _) in

            let udacityDict = data as NSDictionary
            let coursesArray = udacityDict["courses"] as [AnyObject]
            completed(courses: coursesArray)
        }
    }

    class func queryCoursesByTrack(trackType : EdXTrackType, completed : (courses : [AnyObject]) -> Void)
    {
        Alamofire.request(.GET, kUdacityResourceURL).responseJSON() {
            (_, _, data, _) in

            var includedCourses = [AnyObject]()

            let udacityDict = data as NSDictionary
            let coursesArray = udacityDict["courses"] as [AnyObject]

            for course in coursesArray
            {
                let tracks = course["tracks"] as [NSString]

                for track in tracks
                {
                    if contains(tracks, trackType.text())
                    {
                        includedCourses.append(course)
                    }
                }
            }
            completed(courses: includedCourses)
        }
    }
}
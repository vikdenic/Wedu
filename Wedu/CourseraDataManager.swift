//
//  CourseraDataManager.swift
//  Wedu
//
//  Created by Vik Denic on 4/7/15.
//  Copyright (c) 2015 Nektar Labs. All rights reserved.
//

import Foundation
import Alamofire

let kCourseraCoursesResourceURL = "https://www.coursera.org/maestro/api/topic/list?full=1%20or%20https://www.coursera.org/maestro/api/topic/list2"

class CourseraDataManager {
    class func queryAllCourses(completed : (courses : [AnyObject]) -> Void)
    {
        Alamofire.request(.GET, kCourseraCoursesResourceURL).responseJSON() {
            (_, _, data, _) in
            let courseraArray = data as NSArray

            completed(courses: courseraArray)
        }
    }
}
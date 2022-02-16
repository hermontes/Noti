//
//  HomePage.swift
//  Noti
//
//  Created by Nathanael Temesgen on 12/5/21.
//

import SwiftUI

struct HomePage: View {
    private var firstname: String
    private var lastname: String
    private var school: String
    private var schoolId: String
    private var password: String
    
    init(firstname: String, lastname: String, school: String, schoolId: String, password: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.school = school
        self.schoolId = schoolId
        self.password = password
    }
    var body: some View {
        TabView {
            
            SchoolEvents(incomingSchool: school)
                .tabItem{

                    
                    Label("School Events", systemImage: "calendar")
                        .font(.title)
                } .font(.title)
            
            Grades(studName: "\(firstname)")
                .tabItem {
                    Label("Grades", systemImage: "percent")

                        .font(.title)

                }
            
            Teacher(studName: "\(firstname)")
                .tabItem {
                    Label("Teachers", systemImage: "person.3.fill")

                        .font(.title)

                }
        }.font(.title)
    }
}

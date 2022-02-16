//
//  Students.swift
//  Noti
//
//  Created by Nathanael Temesgen on 11/29/21.
//

import Foundation
import FirebaseDatabase

struct DirEntry: Codable, Identifiable {
    var id: String?
    var firstname: String
    var lastname: String
    var school: String
    var schoolid: String
    var password: String
    
    var dict: NSDictionary? {
        if let idStr = id {
            let d = NSDictionary(dictionary: [
                                    "id": idStr, "firstname": firstname, "lastname": lastname, "school": school, "schoolid": schoolid, "password": password ])
            return d
        }
        return nil
    }
    
    static func fromDict(_ d: NSDictionary) -> DirEntry? {
        guard let firstname = d["firstname"] as? String else { return nil }
        guard let lastname = d["lastname"] as? String else { return nil }
        guard let school = d["school"] as? String else { return nil }
        guard let schoolid = d["schoolid"] as? String else { return nil }
        guard let password = d["password"] as? String else { return nil }

        return DirEntry(id: d["id"] as? String, firstname: firstname, lastname: lastname, school: school, schoolid: schoolid, password: password)
    }
}
 
class Directory: ObservableObject {
    @Published var entries: [String:DirEntry] = [:]
    var email = ""
    
    init() {
        //UserDefaults.standard.set("a@a", forKey: "user")
       
        let name = UserDefaults.standard.string(forKey: "user") != nil ? String(UserDefaults.standard.string(forKey: "user")!.split(separator: "@")[0]) : ""
        let rootRef = Database.database().reference()
        rootRef.child(name).getData { err, snapshot in
            DispatchQueue.main.async {
                for child in snapshot.children {
                    if let item = child as? DataSnapshot {
                        if let val = item.value as? NSDictionary,
                           let de = DirEntry.fromDict(val),
                           let id = de.id { self.entries[id] = de }
                    }
                }
            }
        }
        rootRef.child(name).observe(.childAdded) { snapshot in
            if let v = snapshot.value as? NSDictionary,
               let de = DirEntry.fromDict(v),
               let id = de.id { self.entries[id] = de }
        }
        rootRef.child(name).observe(.childRemoved) { snapshot in
            self.entries.removeValue(forKey: snapshot.key)
        }
        rootRef.child(name).observe(.childChanged) { snapshot in
            if let v = snapshot.value as? NSDictionary,
               let de = DirEntry.fromDict(v),
               let id = de.id { self.entries[id] = de }
        }
    }
    
    func addEntry(entry: inout DirEntry) {
        let name = UserDefaults.standard.string(forKey: "user")!.split(separator: "@")[0]
        let rootRef = Database.database().reference()
        let childRef = rootRef.child(String(name)).childByAutoId()
        entry.id = childRef.key
        if let val = entry.dict {
            childRef.setValue(val)
        }
    }
    
    func delEntry(id: String) {
        let name = UserDefaults.standard.string(forKey: "user")!.split(separator: "@")[0]
        entries.removeValue(forKey: id)
        let rootRef = Database.database().reference()
        rootRef.child(String(name)).child(id).removeValue()
    }
}

//
//  DataServices.swift
//  devSocial
//
//  Created by erterfed on 24/2/17.
//  Copyright © 2017 erterfed. All rights reserved.
//

import Foundation
import Firebase

// this is to get the URL
//which would be https://devsocial-62619.firebaseio.com/
//according to GoogleService-Info.plist
let DB_BASE = FIRDatabase.database().reference()


class DataService {
    
    //creating a singleton
    //an instance of Dataservice class that can used globally
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
}

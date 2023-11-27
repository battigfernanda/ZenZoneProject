//
//  FireDBHelper.swift
//  ZenZoneProject
//
//  Created by Muhammad Haris on 27/11/2023.
//

import Foundation
import FirebaseFirestore


class FireDBHelper : ObservableObject{
    @Published var userList = [User]()
    private static var shared : FireDBHelper?
    private var db : Firestore
    
    private init(database : Firestore){
        self.db = database
    }
    
    static func getInstance() -> FireDBHelper{
        
        if(self.shared == nil){
            self.shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return self.shared!
    }
}

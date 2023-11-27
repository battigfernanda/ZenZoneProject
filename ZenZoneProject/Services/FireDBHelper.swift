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
    
    private let COLLECTION_USERS = "Users"
    private let ATTRIBUTE_FIRST_NAME = "firstName"
    private let ATTRIBUTE_LAST_NAME = "lastName"
    private let ATTRIBUTE_AGE = "age"
    private let ATTRIBUTE_USERNAME = "username"
    private let ATTRIBUTE_EMAIL = "email"
    private let ATTRIBUTE_PASSWORD = "password"
    
    
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


func insertUser(user : User ){
    do{
        try self.db
            .collection(self.COLLECTION_USERS)
            .addDocument(from: user)
    }catch let err as NSError{
        print(#function, "Unable to insert due to error  : \(err)")
    }
}


func updateUser(indexToUpdate : Int){
    let documentID = self.userList[indexToUpdate].id!
    
    self.db
        .collection(COLLECTION_USERS)
        .document(documentID)
        .updateData([
            ATTRIBUTE_FIRST_NAME : self.userList[indexToUpdate].firstName
            ATTRIBUTE_LAST_NAME : self.userList[indexToUpdate].lastName
            ATTRIBUTE_AGE : self.userList[indexToUpdate].age
            ATTRIBUTE_USERNAME : self.userList[indexToUpdate].username
            ATTRIBUTE_EMAIL : self.userList[indexToUpdate].email
            ATTRIBUTE_PASSWORD : self.userList[indexToUpdate].password
        ]){error in
            
            if let err = error {
                print(#function, "Unable to update document due to error : \(err)")
            }else{
                print(#function, "Document successfully updated")
            }
        }
    
}

func deleteUser(indexToDelete : Int){
    let documentID = self.userList[indexToUpdate].id!
    
    self.db
        .collection(COLLECTION_USERS)
        .documet(documentID)
        .delete{ error in
            if let err = error{
                print(#function, "Unable to delete due to error : \(err)")
            }else{
                print(#function, "Document deleted successfully")
            }
        }

}

func retriveAllUser(){
    do{
        self.db
            .collection(self.COLLECTION_USERS)
            .addSnapshotListener( { (querySnapshot, error) in
                guard let result = querySnapshot else{
                    print(#function, "No snapshot obtained due to error  : \(error)")
                    return
                }
                
                print(#function, "result querySnapshot : \(result)")
//
//
                
                result.documentChanges.forEach{ (docChange) in
                    do{
                        
                        //obtain the User object from document
                        let user = try docChange.document.data(as: User.self)
                        
                        print(#function, "user retrieved : id : \(user.id), first name: \(user.firstName), last name : \(user.lastName), age : \(user.age)")
                        
                        //to check if the document that has changed exists in the current list of user
                        let matchedIndex = self.userList.firstIndex(where: { ( $0.id?.elementsEqual(docChange.document.documentID))! })
                        
                        if docChange.type == .added{
                            print(#function, "New document is added : \(user.username)")
                            
                            if (matchedIndex != nil){
                                //the object is already in the list
                                //do nothing
                            }
                            else{
                                self.userList.append(user)
                            }
                        }
                        
                        if docChange.type == .modified{
                            print(#function, "Document is updated : \(user.username)")
                            
//
                        }
                        
                        if docChange.type == .removed{
                            print(#function, "Document is removed : \(user.username)")
                            
//
                        }
                        
                    }catch let err as NSError{
                        print(#function, "Unable to retrieve documentChange due to error : \(err)")
                    }
                }
                
            })
                

    }
}catch let err as NSError{
                print(#function, "Unable to retrieve due to error : \(err)")
            }
}

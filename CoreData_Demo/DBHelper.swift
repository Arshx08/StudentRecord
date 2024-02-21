//
//  DBHelper.swift
//  CoreData_Demo
//
//  Created by Arshdeep Singh on 2023-09-27.
//

import Foundation
import CoreData

//ObervableObject is used so that we can use environment object
class DBHelper: ObservableObject{
    
    //using to get list of students from database.
    @Published var studentList = [Student]()

    
    //singleton design pattern
    //singleton object
    
    private static var shared: DBHelper?
    private let moc: NSManagedObjectContext
    
    private let ENTITY_NAME="Student"
    private let ATTRIBUTE_FNAME = "firstName"
    private let ATTRIBUTE_LNAME = "lastName"
    private let ATTRIBUTE_COOP = "co_op"
    private let ATTRIBUTE_GPA = "gpa"
    
    static func getInstance() -> DBHelper{
        if(self.shared == nil){
            shared = DBHelper(context: PersistenceController.preview.container.viewContext)
        }
        return self.shared!
    }
    
    //NSManagedObjectContext helps to track any changes in database
   private init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertStudent(fname: String, lname: String, prog: String, ccr: Int, gpa: Float){
        
        
        do{
            
            //obtain new object to add new data
            let newStudent = NSEntityDescription.insertNewObject(forEntityName: self.ENTITY_NAME, into: self.moc) as! Student
            
            newStudent.id = UUID()
            newStudent.firstName = fname
            newStudent.lastName = lname
            newStudent.program = prog
            newStudent.ccr = Int64(ccr)
            
            if(gpa >= 0 && gpa <= 4.0){
                newStudent.gpa = gpa
            }
            
            if(gpa > 3.5){
                newStudent.co_op = true
            }
            
            //saving into database permanently
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Operation is successfull: \(fname) \(lname)")
            }
            
            
        }catch let err as NSError{
            print(#function,"Unable to insert data: \(err)")
        }
        
    }
    
    func deleteStudent(studentIndex: Int){
        do{
            
            let objToDel = self.studentList[studentIndex]
            self.moc.delete(objToDel)
            
            try self.moc.save()
            
            
            print(#function, "Student \(objToDel.firstName) deleted successfully")
            
            
        }catch let err as NSError{
            print(#function,"Unable to delete the record \(self.studentList[studentIndex].firstName) due to error: \(err)")
        }
    }
    
    func retreiveStudentByFirstname(firstName : String){
        
        let fetchRequest = NSFetchRequest<Student>(entityName: self.ENTITY_NAME)
        
       
        
        
        //filter
        //let nameValue = "Bat"
        let filterFName = NSPredicate(format: "\(self.ATTRIBUTE_FNAME) BEGINSWITH[c] %@", firstName as CVarArg)
        
        fetchRequest.predicate = filterFName
        
        do{
            let result = try self.moc.fetch(fetchRequest)

            
            print(#function,"Number of records retreived ")
            self.studentList = result
            
        }catch let err as NSError{
            print(#function,"Unable to retreive records: \(err)")
        }
        
    }
    
    func retreiveAllStudent(){
        let fetchRequest = NSFetchRequest<Student>(entityName: self.ENTITY_NAME)
        
        //sorting  the record alphabetically
        
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: self.ATTRIBUTE_FNAME, ascending: false)]
        
        //filter
//        let nameValue = "Bat"
//        let filterFName = NSPredicate(format: "firstName == %@", nameValue as CVarArg)
//
//        fetchRequest.predicate = filterFName
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            
            if(result.count > 0){
                
                for stud in result{
                    print(#function, "Result: \(stud.firstName) \(stud.lastName)")
                }
                
                self.studentList = result
            }else{
                print(#function,"There are no records to display")
            }
            
        }catch let err as NSError{
            print(#function,"Unable to retreive records: \(err)")
        }
        
    }
    
    func retreiveStudentById(){
        
    }
    
    func updateStudent( studentIndex: Int){
        do{
            if self.moc.hasChanges{
                try self.moc.save()
                
                print(#function, "Student Updated Successfully")
            }
            
            else{
                print(#function, "No changes detected ")

            }
        }catch let err as NSError{
            print(#function, "Unable to update due to error: \(err)")
        }
    }
    
}

//
//  StudentDetailsView.swift
//  CoreData_Demo
//
//  Created by Arshdeep Singh on 2023-10-04.
//

import SwiftUI

struct StudentDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dbHelper : DBHelper
    
    var selectedStudentIndex: Int = -1
   // @State var selectedStudent: Student?
    
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var program : String = ""
    @State private var tfGpa : String = ""
    @State private var tfCcr : String = ""
    
    
    private var co_op : Bool{
        if(self.gpa > 3.5){
            return true
        }
        return false
    }
    
    
    private var gpa: Float{
        return Float(self.tfGpa) ?? 0.0
    }
    
    private var ccr: Int{
        return Int(self.tfCcr) ?? 0
    }
    
    
    var body: some View {
        VStack{
            
            
        Form{
            TextField("First Name", text: self.$firstName)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
                
            
            TextField("Last Name", text: self.$lastName)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
                
            
            TextField("Program", text: self.$program)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
               
            
            TextField("GPA", text: self.$tfGpa)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
              
            
            TextField("Co-Curricular Record", text: self.$tfCcr)
                .font(.title2)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
               
            
            
            Text("CO-OP Eligibility ? \(self.co_op ? "Yes" : "No")")
            
        }//Form
 
        Button{
            //do validation and verification of the inputs.
            //if all data is valid then add all student to the database
            
            self.updateStudent()
        }label: {
            Text("Save Info")
                .font(.title2)
        }
        .buttonStyle(.borderedProminent)
       
        
            
            
        }//VStack
        .onAppear(perform:{
            
            //Showing existence student info on the page
            self.firstName = self.dbHelper.studentList[selectedStudentIndex].firstName ?? "NA"
            self.lastName = self.dbHelper.studentList[selectedStudentIndex].lastName ?? "NA"
            self.program = self.dbHelper.studentList[selectedStudentIndex].program ?? "NA"
            self.tfCcr = "\(self.dbHelper.studentList[selectedStudentIndex].ccr)"
            self.tfGpa = "\(self.dbHelper.studentList[selectedStudentIndex].gpa)"
   //         self.co_op = self.dbHelper.studentList[selectedStudentIndex].co_op
            
        })
        .navigationTitle("Student Details")
        .navigationBarTitleDisplayMode(.inline)
    }//Body
    
    private func updateStudent(){
        
        //get the updated details from the page
        self.dbHelper.studentList[selectedStudentIndex].firstName = self.firstName
        self.dbHelper.studentList[selectedStudentIndex].lastName = self.lastName
        self.dbHelper.studentList[selectedStudentIndex].program = self.program
        self.dbHelper.studentList[selectedStudentIndex].ccr = Int64(self.ccr)
        self.dbHelper.studentList[selectedStudentIndex].gpa = self.gpa
        self.dbHelper.studentList[selectedStudentIndex].co_op = self.co_op
        
        //Save the information in the database.
        self.dbHelper.updateStudent(studentIndex: self.selectedStudentIndex)
        
        //remove current view/screen from the stack
        dismiss()
        
    }
    
    
    
       
}

struct StudentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDetailsView()
    }
}

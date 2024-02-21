//
//  AddStudentView.swift
//  CoreData_Demo
//
//  Created by Arshdeep Singh on 2023-09-27.
//

import SwiftUI

struct AddStudentView: View {
    
    
    @EnvironmentObject var dbHelper : DBHelper
    
    @Environment(\.dismiss) var dismiss
    
    //private var id = UUID()
    //@State private var studId : String = ""
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State private var program : String = ""
    @State private var tfGpa : String = ""
    @State private var tfCcr : String = ""
  //  @State private var co_op : Bool = false
    
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
                   
                
//                Toggle(isOn: self.$co_op, label: {
//                    Text("CO-OP Elegibility")
//                })
//                .disabled(true)
                
                Text("CO-OP Eligibility ? \(self.co_op ? "Yes" : "No")")
                
            }//Form
     
            Button{
                //do validation and verification of the inputs.
                //if all data is valid then add all student to the database
                self.insertStudent()
            }label: {
            Text("Create Student")
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
        }//VStack
        
        .navigationTitle("Student Info")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
     
        
    }//body
    
    private func insertStudent(){
        
        //save student info into database
        self.dbHelper.insertStudent(fname: self.firstName, lname: self.lastName,
                                    prog: self.program, ccr: self.ccr, gpa: self.gpa)
        
        
        // adding dismiss function
        dismiss()
    }
    
}//View

struct AddStudentView_Previews: PreviewProvider {
    static var previews: some View {
        AddStudentView()
    }
}

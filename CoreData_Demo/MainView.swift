//
//  MainView.swift
//  CoreData_Demo
//
//  Created by Arshdeep Singh on 2023-10-02.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var dbHelper: DBHelper
    @State private var  searchText : String = ""
    
    var body: some View {
        
        NavigationStack{
            VStack{
                List{
                    ForEach(self.dbHelper.studentList.enumerated().map({$0}), id: \.element.self){ studIndex, stud in
                        
                        
                        NavigationLink{
                            StudentDetailsView(selectedStudentIndex: studIndex).environmentObject(self.dbHelper)
                        }label: {
                            HStack{
                                Text(stud.firstName ?? "NA")
                                    .bold()
                                Text(stud.lastName ?? "NA")
                                    .bold()
                            }//HStack
                        }//NavigationLink
                        
                       
                    }//ForEach
                    .onDelete(){ indexSet in
                        for index in indexSet{
                            print(#function,"Trying to delete the student: \(self.dbHelper.studentList[index].firstName)")
                            
                            //delete the student from database
                            self.dbHelper.deleteStudent(studentIndex: index)
                        }
                    }//onDelete
                }//List
                //Search from the list
                .searchable(text: self.$searchText, prompt: "Search by Firstname")
                .onChange(of: self.searchText){ _ in
                    self.runSearch()
                }
            }//VStack
            
            .onAppear(){
                
                //get all students from database
                self.dbHelper.retreiveAllStudent()
                
            
                
            }//OnAppear
            .toolbar(){
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink{
                        AddStudentView().environmentObject(self.dbHelper)
                    } label:{
                        Image(systemName: "plus.square")
                    }
                }//ToolbarItem
            }//toolbar
            .navigationTitle("Student List")
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationStack
    }//Body
    
    private func runSearch(){
        print(#function,"Search text: \(self.searchText)")
        
        if (self.searchText.isEmpty){
            self.dbHelper.retreiveAllStudent()
        }else{
            self.dbHelper.retreiveStudentByFirstname(firstName: self.searchText )
        }
    }
    
    
}//mainView

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

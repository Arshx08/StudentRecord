//
//  CoreData_DemoApp.swift
//  CoreData_Demo
//
//  Created by Arshdeep Singh on 2023-09-27.
//

import SwiftUI

@main
struct CoreData_DemoApp: App {
    
    let persistenceController = PersistenceController.shared
    let dbHelper = DBHelper.getInstance()
    
   // let db = DBHelper(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            //            ContentView()
            //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
  
            MainView().environmentObject(self.dbHelper)
                        
        }
    }
}

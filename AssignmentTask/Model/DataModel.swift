//
//  DataModel.swift
//  AssignmentTask
//
//  Created by SAIKAT GHOSH on 21/06/22.
//

import Foundation

struct DataModel: Codable {
    var id : Int?
    var author : String?
    var width : Int?
    var height : Int?
    var url : String?
    var download_url : String?
    
    init() throws {
        
    }
    
    
    init(id: Int?, author: String?,
         width: Int?, height : Int?,
         url: String?, download_url: String?) {
            self.id = id
            self.author = author
            
        }
}

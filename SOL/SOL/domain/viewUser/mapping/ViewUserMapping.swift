//
//  ViewUserMapping.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation

public class ViewUserMapping {
    
    public static func mapping(response: [ViewUserResponse]) -> [ViewUserEntity] {
        var result: [ViewUserEntity] = []
        
        for resp:ViewUserResponse in response {
            result.append(mapping(response: resp))
        }
        return result
    }
    
    public static func mapping(response: ViewUserResponse) -> ViewUserEntity {
        let viewUserEntity: ViewUserEntity = ViewUserEntity()
        viewUserEntity.id =  response.id!
        viewUserEntity.canEdit =  response.canEdit == true
        viewUserEntity.createdFromTemplateId =  response.createdFromTemplateId
        viewUserEntity.hasNewTaskToAdd =  response.hasNewTaskToAdd == true
        viewUserEntity.hasTaskAdded =  response.hasTaskAdded == true
        viewUserEntity.ownerId =  response.ownerId
        viewUserEntity.view =  response.view

        
        return viewUserEntity
    }
    

}

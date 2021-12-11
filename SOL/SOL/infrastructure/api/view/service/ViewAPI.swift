//
//  ViewAPI.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation


class ViewAPI: RequestService, ViewUserRepositoryPort {
    func myRoot(responseFunc: @escaping ApiResponseProtocol<[ViewUserResponse]>){
        self.requestFormUrl(url: ViewUserRoutes.MY_ROOT, method: "GET", responseFunc: responseFunc)
    }
            
}

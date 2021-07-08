//
//  ReceiveReponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation


public class ReceiveReponse<ResponseSuccess, ResponseFailure>{
    var success:ResponseSuccess?
    var error:ResponseFailure?
    
    init(success:ResponseSuccess?, error:ResponseFailure?){
        self.success = success
        self.error = error
    }
    
    public static func of(success:ResponseSuccess?, error:ResponseFailure?) -> ReceiveReponse{
        return ReceiveReponse(success: success, error: error)
    }
}

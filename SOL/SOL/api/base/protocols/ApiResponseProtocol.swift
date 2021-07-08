//
//  SignUpProtocol.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

typealias ApiResponseProtocol<T:Codable> = (_ success: BaseApiResponse<T>?, _ error: BaseApiErrorResponse?, _ isSuccess: Bool) -> Void

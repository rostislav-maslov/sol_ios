//
//  AppStatePublisher.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation
import Combine



public struct SolPublisher<ResponseSuccess, ResponseFailure>: Publisher{
    
    public typealias Output = ReceiveReponse<ResponseSuccess, ResponseFailure>
    public typealias Failure = Never
    var useCase: UseCase<ResponseSuccess, ResponseFailure>!
    
    public init(useCase: UseCase<ResponseSuccess, ResponseFailure>){
        self.useCase = useCase
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, ReceiveReponse<ResponseSuccess, ResponseFailure> == S.Input {
        let subscription = Subscription(subscriber: subscriber, useCase: self.useCase)
        subscriber.receive(subscription: subscription)
    }
}

//MARK: ----------------
private extension SolPublisher{
    final class Subscription<S: Subscriber> where S.Input == Output, S.Failure == Failure {
        //private let output: Output
        private var subscriber: S?
        var userCase: UseCase<ResponseSuccess, ResponseFailure>!
        
        init(subscriber: S, useCase:UseCase<ResponseSuccess, ResponseFailure>) {
            //self.output = output
            self.subscriber = subscriber
            self.userCase = useCase
        }
    }
}

//MARK: ----------------
extension SolPublisher.Subscription: Subscription{
    func request(_ demand: Subscribers.Demand) {
        // We used to check if `subscriber` is `nil` here...
        guard let subscriber = subscriber else {
            return
        }
        
        self.userCase.execute { success, error in
            _ = subscriber.receive(ReceiveReponse(success: success, error: error))
        }            
        
    }
}

//MARK: ----------------
extension SolPublisher.Subscription: Cancellable {
    func cancel() {
        subscriber = nil
    }
}

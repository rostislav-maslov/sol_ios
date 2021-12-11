//
//  ViewUserStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation
import Combine

public class ViewUserStore: ObservableObject {
    @Published var all:[String: ViewUserEntity] = [String: ViewUserEntity]()
    @Published var root:[ViewUserEntity] = []
    
    private var disposables = Set<AnyCancellable>()
    private let port:ViewUserRepositoryPort = SolApiService.api().view
}

//MARK: - Загрузка
extension ViewUserStore {
    func sync(){
        SolPublisher<[ViewUserEntity], Bool>(useCase: GetRootViewUserUseCase(self.port, input: GetRootViewUserUseCase.Input()))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let views = publisherReponse.success!
                    
                    for view in views {
                        self?.all[view.id] = view
                    }
                    
                    self?.root = views
                }else {
                }
                               
            }
            .store(in: &disposables)
    }
}

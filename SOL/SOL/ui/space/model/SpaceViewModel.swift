//
//  SpaceViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI
import Combine

public class SpaceViewModel: NSObject, ObservableObject, UITextViewDelegate{
    @Published var spaceId:String
    @Published var space: SpaceEntity = SpaceEntity()
    @Published var state: ViewState = ViewState.INITIALIZATION
    @Published var activeTab = 0
    @Published var activeTabMax = 1
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    @Published var actionDone = false
    @Published var titleSize:CGFloat = (24 + 8) * 1
    @Published var detectFirstSizeTitle:Bool = false
    @Published var firstSizeTitle:CGFloat = 0
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
    
    init(_ spaceId:String){
        self.spaceId = spaceId
    }
    
    func inRow() -> Int {
        let screenSize: CGRect = UIScreen.main.bounds
        print(screenSize.width)
        var inRow:Int = 28
        if screenSize.width <= 320 {
            inRow = 24
        }else if screenSize.width <= 375 {
            inRow = 28
        }else if screenSize.width <= 390 {
            inRow = 32
        }else if screenSize.width <= 414 {
            inRow = 38
        }else if screenSize.width <= 428 {
            inRow = 40
        }
        return inRow
    }
    
    func calcTitleHeight() -> CGFloat{        
        let lines:Int = space.title.count / inRow() + 1
        //self.titleSize = (24 + 8) * CGFloat.init(lines)
        return (24 + 8) * CGFloat.init(lines)
    }
    
    func load(){
        self.state = ViewState.LOADING
        SolPublisher<SpaceEntity, Bool>(useCase: SpaceUseCase(self.port, SpaceUseCase.Input.of(self.spaceId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    self?.state = ViewState.NORMAL
                    self?.space = publisherReponse.success!
                }else {
                    self?.state = ViewState.ERROR
                    self?.space = SpaceEntity()
                }                                
            }
            .store(in: &disposables)

    }
    
    public func saveTitleIcon(){
        SolPublisher<SpaceEntity, Bool>(useCase:
                                            UpdateTitleIconSpaceUseCase(
                                                self.port,
                                                UpdateTitleIconSpaceUseCase.Input.init(id: self.spaceId, title: self.space.title, emoji: space.icon.data)))
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] publisherReponse in
                
            }
            .store(in: &disposables)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let sizeThatFitsTextView = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat(MAXFLOAT)))
        let heightOfText = sizeThatFitsTextView.height
        space.title = textView.text
        self.titleSize = heightOfText
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            self.saveTitleIcon()            
        }
        return true
    }
}

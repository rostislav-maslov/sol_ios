//
//  SpaceViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI
import Combine

public class SpaceViewModel: NSObject, ObservableObject, DaySchedulerProtocol{
    var spaceId:String?
    @Published var state: ViewState = ViewState.INITIALIZATION
    var spaceStore: SpaceStore?
    var slotStore: SlotStore?
    
    @Published var activeTab = 0
    @Published var activeTabMax = 1
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    @Published var actionDone = false
    @Published var showPlanning = false
    @Published var stopEditIcon = false
    @Published var emoji = ""
    
    @Published var bottomButtonType: BottomButtonType = BottomButtonType.ADD_TASK
    var emojiTextField:UIEmojiTextField?
            
    public var scrollViewProxy:ScrollViewProxy?
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
    private let portTasks:TaskRepositoryPort = SolApiService.api().task
    
    func load(){
        spaceStore?.sync(spaceId: self.spaceId!)                
    }
    
}

extension SpaceViewModel {
    static func forRender() -> SpaceViewModel{
        let s = SpaceViewModel()
        //s.space.title = "asfdasf asdf asd f"
        //s.space.icon.data = "😀"
        return s
    }
    
    func taskDidCreated() -> Void {
        withAnimation {
            scrollViewProxy?.scrollTo("ListLastItem", anchor: .bottom)
        }        
    }
}

//MARK: DaySchedulerProtocol
extension SpaceViewModel {
    func openPlanning() {
        showPlanning = true
    }
    
    func newSlotName() -> String {
        return ""
    }
    
    func addSlot(startTime: Date, endTime: Date) {
//        let slot: SlotEntity = SlotEntity()
//        slot.id = UUID().uuidString
//        slot.title = task.title
//        slot.startTime = startTime
//        slot.endTime = endTime
//        slot.spaceId = self.spaceId
//        slot.slotsMilliseconds = endTime.millisecondsSince1970 - startTime.millisecondsSince1970
//        slot.isDraft = true
//        slot.timezone = Date().timezone
//        task.slots.append(slot)
    }
    
    func drafts () -> [SlotEntity] {
        return []
    }
  
    func changeTimeSlot(slotId: String, startTime: Date, endTime: Date) {
        
    }
    
    func onClose() {
        showPlanning = false
    }
    
    func onSubmit() {
        showPlanning = false
    }
    
    func onTapEvent(slot: SlotEntity) {
        // NOTE ignore
    }
    
    func onDeleteDraft(slotId: String) {        
    }

}

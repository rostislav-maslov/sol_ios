//
//  EditViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import Combine
import AlertToast

public class EditViewModel: NSObject, ObservableObject{
    
    @Published var isTarget = true
    @Published var taskId = ""
    @Published var spaceId = ""
    @Published var placeholder: String = "🪐"
    @Published var emoji: String = "🪐"
    @Published var stopEditIcon = false
    @Published var actionToggle = false
    @Published var bottomButtonType = BottomButtonType.ADD_TASK
    @Published var titleSize = 14.0
    
    @Published var viewUserEntity: ViewUserEntity = ViewUserEntity()
    
    @Published var createMode = false
    
    @Published var showToast = false
    @Published var toastTitle = ""
    @Published var toastSubtitle = ""
    
    var store: ViewUserStore?
    var spaceStore: SpaceStore?
}

extension EditViewModel {
    func initEdit(viewId: String){
        self.viewUserEntity = store!.all[viewId]!
        self.createMode = false
    }
    
    func initCreate(){
        self.viewUserEntity = ViewUserEntity()
        self.viewUserEntity.view = ViewResponse(params: [])
        self.viewUserEntity.view?.icon = IconReponse(data: "🪐", type: "EMOJI")
        self.viewUserEntity.view?.title = "New Smart View"
        
        self.viewUserEntity.view!.viewType = ViewType.CUSTOM
        self.viewUserEntity.view!.addedType = AddedType.MANUALLY
        self.viewUserEntity.view!.description = ""
        self.viewUserEntity.view!.displayMode = DisplayMode.LIST
        self.viewUserEntity.view!.sortType = SortType.BY_DEADLINE
        
        self.createMode = true
        
    }
    
    func confCallback(viewUserStore: ViewUserStore) {
        viewUserStore.viewUserConf.viewTypeChooseSheet = self.viewTypeChooseSheet
        viewUserStore.viewUserConf.displayModeChooseSheet = self.displayModeChooseSheet
        viewUserStore.viewUserConf.addedTypeChooseSheet = self.addedTypeChooseSheet
        viewUserStore.viewUserConf.sortChooseSheet = self.sortChooseSheet
    }
}

// MARK: - Callbacks
extension EditViewModel {
    func displayModeChooseSheet (_ value: DisplayMode) {
        self.viewUserEntity.view?.displayMode = value
        
    }
    func addedTypeChooseSheet(_ value: AddedType) {
        self.viewUserEntity.view?.addedType = value
    }
    func sortChooseSheet(_ value: SortType) {
        self.viewUserEntity.view?.sortType = value
    }
    //    var slotChooseSheet : (() -> Void)?
    //    var notificationChooseSheet : (() -> Void)?
    //    var repeatChooseSheet : (() -> Void)?
    //    var overdueChooseSheet : (() -> Void)?
    //    var taskIdClosedChooseSheet: (() -> Void)?
    //    var deadlineDidChangeSheet: (() -> Void)?
    //    var deadlineExactDateSheet: (() -> Void)?
    //    var deadlineRelativeChooseSheet: (() -> Void)?
    //    var spaceChooseSheet: (() -> Void)?
    //    var chooseParamSheet: (() -> Void)?
    func viewTypeChooseSheet(_ value: ViewType){
        self.viewUserEntity.view?.viewType = value
    }
    
    func addParamCallback(paramType: ParamsType) {
        var paramResponse: ParamResponse = ParamResponse()
        paramResponse.id = UUID().uuidString
        paramResponse.type = paramType
        if paramType == ParamsType.DEADLINE_RELATIVE_DATE {
            paramResponse.valueString = "0"
        }else if paramType == ParamsType.FROM_SPACE {
            paramResponse.valueString = spaceStore?.spacesOrdered[0].id
        }else {
            paramResponse.valueString = ""
        }
        
        paramResponse.valueBool = false
        paramResponse.valueDate = Date()
        
        self.viewUserEntity.view?.params.append(paramResponse)
        store?.chooseParamToAddSheet = false
        
        open(paramResponse: paramResponse)
    }
    
    func open(paramResponse: ParamResponse){
        if self.viewUserEntity.canEdit == false {
            store?.sorrySheet = true
            return
        }
        switch paramResponse.type {
        case .SLOT_TIME:
            store?.openSlotChoose(id: paramResponse.id!, value: paramResponse.valueBool!, didChange: self.slotTimeDidChange, delete: self.paramDelete)
        case .NOTIFICATION:
            store?.openNotificationChoose(id: paramResponse.id!, value: paramResponse.valueBool!, didChange: self.notificationDidChange, delete: self.paramDelete)
        case .DEADLINE_EXACT_DATE:
            store?.openDeadlineExactDateChoose(id: paramResponse.id!, value: paramResponse.valueDate!, didChange: self.deadlineExactDidChange, delete: self.paramDelete)
        case .HAS_REPEAT:
            store?.openOpenRepeatChoose(id: paramResponse.id!, value: paramResponse.valueBool!, didChange: self.hasRepeatDidChange, delete: self.paramDelete)
        case .DEADLINE_RELATIVE_DATE:
            store?.openDeadlineRelativeChoose(id: paramResponse.id!, value: Int(paramResponse.valueString!)!, didChange: self.deadlineRelativeDateDidChange, delete: self.paramDelete)
        case .TASK_IS_OVERDUE:
            store?.openOverdueChoose(id: paramResponse.id!, value: paramResponse.valueBool!, didChange: self.taskIsOverdueDidChange, delete: self.paramDelete)
        case .CLOSED:
            store?.openTaskDidClosedChoose(id: paramResponse.id!, value: paramResponse.valueBool!, didChange: self.closedDidChange, delete: self.paramDelete)
        case .FROM_SPACE:
            store?.openSpaceChoose(id: paramResponse.id!, value: paramResponse.valueString!, didChange: self.spaceDidChange, delete: self.paramDelete)
        case .DEADLINE_CHANGED_FEW_TIMES:
            store?.openDeadlineDidChangeChoose(id: paramResponse.id!, value: paramResponse.valueBool!, didChange: self.deadlineChangedFewTimesChange, delete: self.paramDelete)
        case .none:
            var _ = ""
        }
    }
    
    func slotTimeDidChange(id: String, value: Bool){
        store?.slotChooseSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueBool = value
            }
        }
    }
    
    func notificationDidChange(id: String, value: Bool ){
        store?.notificationChooseSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueBool = value
            }
        }
    }
    
    func deadlineExactDidChange(id: String, value: Date) {
        store?.deadlineExactDateSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueDate = value
            }
        }
    }
        
    func hasRepeatDidChange(id: String, value: Bool){
        store?.repeatChooseSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueBool = value
            }
        }
    }

    func deadlineRelativeDateDidChange(id: String, value: Int){
        store?.deadlineRelativeChooseSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueString = String(value)
            }
        }
    }
    
    func taskIsOverdueDidChange(id: String, value: Bool){
        store?.overdueChooseSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueBool = value
            }
        }
    }
    func closedDidChange(id: String, value: Bool){
        store?.taskIdClosedChooseSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueBool = value
            }
        }
    }

    func spaceDidChange(id: String, value: String){
        store?.spaceChooseSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueString = value
            }
        }
    }
    func deadlineChangedFewTimesChange(id: String, value: Bool){
        store?.deadlineDidChangeSheet = false
        for index in self.viewUserEntity.view!.params.indices {
            if self.viewUserEntity.view!.params[index].id == id {
                self.viewUserEntity.view!.params[index].valueBool = value
            }
        }
    }

    
    func paramDelete(id: String) {
        self.viewUserEntity.view?.params.removeAll(where: { paramReponse in
            return paramReponse.id == id
        })
        
        store?.slotChooseSheet = false
        store?.notificationChooseSheet = false
        store?.repeatChooseSheet = false
        store?.overdueChooseSheet = false
        store?.taskIdClosedChooseSheet = false
        store?.deadlineDidChangeSheet = false
        store?.deadlineExactDateSheet = false
        store?.deadlineRelativeChooseSheet = false
        store?.spaceChooseSheet = false
        store?.chooseParamToAddSheet = false
    }
}

// MARK: - Saved
extension EditViewModel{
    func delete(){
        SolApiService.api().view.deleteViewUser(viewId: self.viewUserEntity.id) { (success, error, isSuccess) in
            self.store?.sync()
        }
    }
    func save(){
        if self.createMode == true {
            var createViewUserRequest: CreateViewUserRequest = CreateViewUserRequest(
                addedType: self.viewUserEntity.view!.addedType!,
                description: self.viewUserEntity.view!.description!,
                displayMode: self.viewUserEntity.view!.displayMode!,
                icon: self.viewUserEntity.view!.icon!,
                params: self.viewUserEntity.view!.params,
                sortType: self.viewUserEntity.view!.sortType!,
                title: self.viewUserEntity.view!.title!,
                viewType: self.viewUserEntity.view!.viewType!)
            createViewUserRequest.icon.data = self.emoji
        
            if createViewUserRequest.viewType == .CUSTOM {
                createViewUserRequest.params = []
            }
            
            SolApiService.api().view.createView(request: createViewUserRequest) { (success, error, isSuccess) in
                self.store?.sync()
//                if isSuccess == true && success != nil {
//                    let viewUserResponse = success?.result
//                    self.viewUserEntity.id = viewUserResponse!.id!
//                    self.createMode = false
//                    self.toastTitle = "View did created"
//                    self.toastSubtitle = "Take a look on Customize Screen to see all your Smart Views"
//                    self.showToast = true
//                } else {
//                    // TODO
//                }
            }
        } else{
            var createViewUserRequest: CreateViewUserRequest = CreateViewUserRequest(
                addedType: self.viewUserEntity.view!.addedType!,
                description: self.viewUserEntity.view!.description!,
                displayMode: self.viewUserEntity.view!.displayMode!,
                icon: self.viewUserEntity.view!.icon!,
                params: self.viewUserEntity.view!.params,
                sortType: self.viewUserEntity.view!.sortType!,
                title: self.viewUserEntity.view!.title!,
                viewType: self.viewUserEntity.view!.viewType!)
            createViewUserRequest.icon.data = self.emoji
            
            if createViewUserRequest.viewType == .CUSTOM {
                createViewUserRequest.params = []
            }
            
            SolApiService.api().view.updateView(viewId: self.viewUserEntity.id, request: createViewUserRequest) { (success, error, isSuccess) in
                self.store?.sync()
//                let viewUserResponse = success?.result
//                self.viewUserEntity.id = viewUserResponse!.id!
//                self.createMode = false
//                self.toastTitle = "View did update"
//                self.toastSubtitle = "Take a look on Customize Screen to see all your Smart Views"
//                self.showToast = true
                
                
            }
        }
    }
}


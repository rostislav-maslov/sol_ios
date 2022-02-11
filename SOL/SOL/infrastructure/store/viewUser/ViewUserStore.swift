//
//  ViewUserStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation
import Combine
import SwiftUI

public class ViewUserStore: ObservableObject {
    @Published var all:[String: ViewUserEntity] = [String: ViewUserEntity]()
    @Published var root:[ViewUserEntity] = []
    @Published var byTask:[String: [TaskInViewResponse]] = [String: [TaskInViewResponse]]()
    @Published var byView:[String: [TaskInViewResponse]] = [String: [TaskInViewResponse]]()
    @Published var hides:[ViewUserEntity] = []
    
    @Published var showAddToViewCount = 0
    @Published var showAddToViewLimit = 5
    
    @Published var showSortSheet = false
    @Published var showDisplayModeSheet = false
    @Published var showFilterSheet = false
    @Published var sorrySheet = false
    
    /// Choose
    @Published var displayModeChooseSheet = false
    @Published var displayModeChooseValue = DisplayMode.LIST
    
    @Published var addedTypeChooseSheet = false
    @Published var addedTypeChooseValue = AddedType.AUTO
    
    @Published var sortChooseSheet = false
    @Published var sortChooseValue = SortType.CUSTOM
    
    @Published var viewTypeChooseSheet = false
    @Published var viewTypeChooseValue = ViewType.CUSTOM
    
    /// Params
    @Published var slotChooseSheet = false
    @Published var slotChooseValue = false
    @Published var slotChooseId:String = ""
    var slotChooseDidChange: ((_ id: String, _ value: Bool) -> Void)?
    var slotChooseDelete: ((_ id: String) -> Void)?
    
    @Published var notificationChooseSheet = false
    @Published var notificationChooseValue = false
    @Published var notificationChooseId = ""
    var notificationChooseDidChange: ((_ id: String, _ value: Bool) -> Void)?
    var notificationChooseDelete: ((_ id: String) -> Void)?
    
    @Published var repeatChooseSheet = false
    @Published var repeatChooseValue = false
    @Published var repeatChooseId = ""
    var repeatChooseDidChange: ((_ id: String, _ value: Bool) -> Void)?
    var repeatChooseDelete: ((_ id: String) -> Void)?
    
    @Published var overdueChooseSheet = false
    @Published var overdueChooseValue = false
    @Published var overdueChooseId = ""
    var overdueDidChange: ((_ id: String, _ value: Bool) -> Void)?
    var overdueChooseDelete: ((_ id: String) -> Void)?
    
    @Published var taskIdClosedChooseSheet = false
    @Published var taskIdClosedChooseValue = false
    @Published var taskIdClosedChooseId = ""
    var taskIdClosedDidChange: ((_ id: String, _ value: Bool) -> Void)?
    var taskIdClosedDelete: ((_ id: String) -> Void)?
    
    @Published var deadlineDidChangeSheet = false
    @Published var deadlineDidChangeValue = false
    @Published var deadlineDidChangeId = ""
    var deadlineDidSeveralTimesDidChange: ((_ id: String, _ value: Bool) -> Void)?
    var deadlineDidDelete: ((_ id: String) -> Void)?
    
    @Published var deadlineExactDateSheet = false
    @Published var deadlineExactDateValue = Date()
    @Published var deadlineExactDateId = ""
    var deadlineExactDateDidChange: ((_ id: String, _ value: Date) -> Void)?
    var deadlineExactDateDelete: ((_ id: String) -> Void)?
    
    /// В барабане заложить понедельно^ может даже сделать типа енам:
    /// -1 просрочено
    /// 0 сегодня
    /// 1 завтра
    /// 2 в течении недели
    /// 3 в течении двух недель
    /// 4 в течении текущего месяца
    @Published var deadlineRelativeChooseSheet = false
    @Published var deadlineRelativeChooseValue = 0
    @Published var deadlineRelativeChooseId = ""
    var deadlineRelativeDidChange: ((_ id: String, _ value: Int) -> Void)?
    var deadlineRelativeDelete: ((_ id: String) -> Void)?
    
    @Published var spaceChooseSheet = false
    @Published var spaceChooseValue = ""
    @Published var spaceChooseId = ""
    var spaceDidChange: ((_ id: String, _ value: String) -> Void)?
    var spaceDelete: ((_ id: String) -> Void)?
    
    ///Выбираем параметр для добавления
    @Published var chooseParamToAddSheet = false
    var addParamToView: ((_ paramType: ParamsType) -> Void)?
    
        
    var viewUserConf = ViewUserConf()
    
    var keyShowAddToViewLimit = "ShowAddToViewLimit"
    
    var taskStore: TaskStore?
    
    private var disposables = Set<AnyCancellable>()
    private let port:ViewUserRepositoryPort = SolApiService.api().view
}

//MARK: - Загрузка
extension ViewUserStore {
    
    func syncShowAddToViewCount(){
        self.showAddToViewCount = UserDefaults.standard.integer(forKey: keyShowAddToViewLimit)
    }

    func addShowToViewCount(){
        if self.showAddToViewCount < self.showAddToViewLimit + 20 {
            self.showAddToViewCount = self.showAddToViewCount + 1
            UserDefaults.standard.set(self.showAddToViewCount, forKey: keyShowAddToViewLimit)
        }
    }
    
    func toggleTaskInView(taskId: String, viewId: String){
        self.addShowToViewCount()
        if self.byTask[taskId] == nil {
            createTaskInView(taskId: taskId, viewId: viewId)
        }
        
        if self.byTask[taskId]!.contains(where: { taskInView in
            return viewId == taskInView.viewId
        }) == true {
            deleteTaskInView(taskId: taskId, viewId: viewId)
        }else {
            createTaskInView(taskId: taskId, viewId: viewId)
        }
    }
    
    func deleteTaskInView(taskId: String, viewId: String){
        SolPublisher<String, Bool>(useCase: DeleteTaskInViewUseCase(self.port, input: DeleteTaskInViewUseCase.Input(taskId: taskId, viewId: viewId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {

                    if self?.byTask[taskId] == nil {
                        return
                    }
                    
                    let views: [TaskInViewResponse] = self!.byTask[taskId]!
                    self?.byTask[taskId] = views.filter {$0.viewId != viewId}
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func createTaskInView(taskId: String, viewId: String){
        SolPublisher<String, Bool>(useCase: CreateTaskInViewUseCase(self.port, input: CreateTaskInViewUseCase.Input(taskId: taskId, viewId: viewId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {                    
                    var views: [TaskInViewResponse] = []
                    if self?.byTask[taskId] != nil {
                        views = self!.byTask[taskId]!
                    }
                    
                    if views.contains(where: { taskInView in
                        return taskInView.viewId == viewId
                    }) == false {
                        views.append(TaskInViewResponse(viewId: viewId, sortNum: 0, taskId: taskId))
                    }
                                        
                    self?.byTask[taskId] = views
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func syncByTask(taskId: String){
        SolPublisher<[TaskInViewResponse], Bool>(useCase: FindByTaskUseCase(self.port, input: FindByTaskUseCase.Input(taskId: taskId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let ids = publisherReponse.success!
                    var res:[ViewUserEntity] = []
                    for view in ids {
                        if self?.all[view.viewId!] != nil {
                            res.append(self!.all[view.viewId!]!)
                        }
                    }
                    self?.byTask[taskId] = ids
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func syncTaskInView(viewId: String){
        SolPublisher<[TaskInViewResponse], Bool>(useCase: FindByViewUseCase(self.port, input: FindByViewUseCase.Input(viewId: viewId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let result = publisherReponse.success!
                    var taskToAdd:[TaskInViewResponse] = []
                    for taskInView in result {
                        let task = self?.taskStore?.tasks[taskInView.taskId!]
                        if (task?.status == TaskStatus.OPEN) {
                            self?.taskStore?.syncTask(taskId: taskInView.taskId!, silent: true)
                            taskToAdd.append(taskInView)
                        }
                    }
                    self?.byView[viewId] = taskToAdd
                }else {
                }
            }
            .store(in: &disposables)
    }
    
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
        
        syncHides()
    }
    
    func syncHides() {
        SolPublisher<[ViewUserEntity], Bool>(useCase: HidesViewsUseCase(self.port, input: HidesViewsUseCase.Input()))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let views = publisherReponse.success!
                    self?.hides = views
                    for view in views {
                        self?.all[view.id] = view
                    }
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func hide(viewId: String){
        SolPublisher<Bool, Bool>(useCase: HideViewUseCase(self.port, input: HideViewUseCase.Input(viewId: viewId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                self?.sync()
            }
            .store(in: &disposables)
    }
    
    func show(viewId: String){
        SolPublisher<Bool, Bool>(useCase: ShowViewUseCase(self.port, input: ShowViewUseCase.Input(viewId: viewId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                self?.sync()
            }
            .store(in: &disposables)
    }
    
    func reorder(_ viewId: String, _ newIndex: Int){
        if newIndex == self.root.count - 1 {
            var fromIndex = 0
            for (index, element) in self.root.enumerated() {
                if element.id == viewId {
                    fromIndex = index
                }
            }
            let fromOffsets: IndexSet = IndexSet(integer: newIndex)
            self.root.move(fromOffsets: fromOffsets, toOffset: fromIndex)
        }else {
            var fromIndex = 0
            for (index, element) in self.root.enumerated() {
                if element.id == viewId {
                    fromIndex = index
                }
            }
            let fromOffsets: IndexSet = IndexSet(integer: fromIndex)
            self.root.move(fromOffsets: fromOffsets, toOffset: newIndex)
        }
                
        SolApiService.api().view.reorder(viewsId: self.root.map({ view in
            return view.id
        })) { success, error, isSuccess in
            
        }
        
    }
}

extension ViewUserStore {
    
    func openSlotChoose(id: String, value: Bool, didChange: @escaping ((_ id: String, _ value: Bool) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.slotChooseSheet = true
        self.slotChooseValue = value
        self.slotChooseId = id
        self.slotChooseDidChange = didChange
        self.slotChooseDelete = delete
    }
    
    func openNotificationChoose(id: String, value: Bool, didChange: @escaping ((_ id: String, _ value: Bool) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.notificationChooseSheet = true
        self.notificationChooseValue = value
        self.notificationChooseId = id
        self.notificationChooseDidChange = didChange
        self.notificationChooseDelete = delete
    }
    
   
    func openOpenRepeatChoose(id: String, value: Bool, didChange: @escaping ((_ id: String, _ value: Bool) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.repeatChooseSheet = true
        self.repeatChooseValue = value
        self.repeatChooseId = id
        self.repeatChooseDidChange = didChange
        self.repeatChooseDelete = delete
    }
    
    func openOverdueChoose(id: String, value: Bool, didChange: @escaping ((_ id: String, _ value: Bool) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.overdueChooseSheet = true
        self.overdueChooseValue = value
        self.overdueChooseId = id
        self.overdueDidChange = didChange
        self.overdueChooseDelete = delete
    }
    
    func openTaskDidClosedChoose(id: String, value: Bool, didChange: @escaping ((_ id: String, _ value: Bool) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.taskIdClosedChooseSheet = true
        self.taskIdClosedChooseValue = value
        self.taskIdClosedChooseId = id
        self.taskIdClosedDidChange = didChange
        self.taskIdClosedDelete = delete
    }
    
    func openDeadlineDidChangeChoose(id: String, value: Bool, didChange: @escaping ((_ id: String, _ value: Bool) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.deadlineDidChangeSheet = true
        self.deadlineDidChangeValue = value
        self.deadlineDidChangeId = id
        self.deadlineDidSeveralTimesDidChange = didChange
        self.deadlineDidDelete = delete
    }
    
    func openDeadlineExactDateChoose(id: String, value: Date, didChange: @escaping ((_ id: String, _ value: Date) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.deadlineExactDateSheet = true
        self.deadlineExactDateValue = value
        self.deadlineExactDateId = id
        self.deadlineExactDateDidChange = didChange
        self.deadlineExactDateDelete = delete
        
    }
    
    func openDeadlineRelativeChoose(id: String, value: Int, didChange: @escaping ((_ id: String, _ value: Int) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.deadlineRelativeChooseSheet = true
        self.deadlineRelativeChooseValue = value
        self.deadlineRelativeChooseId = id
        self.deadlineRelativeDidChange = didChange
        self.deadlineRelativeDelete = delete
    }
    
    func openSpaceChoose(id: String, value: String, didChange: @escaping ((_ id: String, _ value: String) -> Void), delete: @escaping  ((_ id: String) -> Void)){
        self.spaceChooseSheet = true
        self.spaceChooseValue = value
        self.spaceChooseId = id
        self.spaceDidChange = didChange
        self.spaceDelete = delete
    }
    
    func openChooseParamToAddSheet(addParam: @escaping (_ paramType: ParamsType) -> Void){
        self.chooseParamToAddSheet = true
        self.addParamToView = addParam
    }
}

//
//  EditViewPage.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.02.2022.
//

import Foundation
import SwiftUI
import AlertToast

public struct EditViewPage: View {
    var viewId: String?
    var isCreate:Bool = false
    
    @StateObject var model: EditViewModel = EditViewModel()
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    @Environment(\.presentationMode) var presentationMode        
    
    init(viewId: String){
        self.viewId = viewId
        self.isCreate = false
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    init(){
        self.viewId = nil
        self.isCreate = true
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    public var body: some View {
        ZStack {
            List{
                titleContent
                
                mainParamsContent
                
                if model.viewUserEntity.view?.viewType == .PARAMS {
                    VStack{
                        Spacer().frame(height: 24)
                        Text("Smart params")
                            .font(SolFonts.font(size: 24, weight: Font.Weight.bold, color: SolColor.colors().fontColors.normal))
                            .foregroundColor(SolColor.colors().fontColors.normal)
                        Spacer().frame(height: 16)
                    }
                    .listRowSeparator(Visibility.hidden)
                    .listRowBackground(SolColor.colors().screen.background)
                    
                    if model.viewUserEntity.view != nil {
                        if model.viewUserEntity.view!.params.count == 0 {
                            Text("No params added. ")
                        }
                        ForEach(model.viewUserEntity.view!.params, id: \.id) { param in
                            if param.type == ParamsType.SLOT_TIME ||
                                param.type == ParamsType.NOTIFICATION ||
                                param.type == ParamsType.HAS_REPEAT ||
                                param.type == ParamsType.DEADLINE_CHANGED_FEW_TIMES ||
                                param.type == ParamsType.TASK_IS_OVERDUE ||
                                param.type == ParamsType.CLOSED {
                                EditViewChooseLineItem(
                                    title: param.type!.description,
                                    value: param.valueBool! ? "yes" : "no") {
                                    model.open(paramResponse: param)
                                }
                            }
                            
                            if param.type == .DEADLINE_EXACT_DATE {
                                EditViewChooseLineItem(
                                    title: param.type!.description,
                                    value: param.valueDate!.beautify) {
                                    model.open(paramResponse: param)
                                }
                            }
                                                    
                            if param.type == .FROM_SPACE {
                                EditViewChooseLineItem(
                                    title: param.type!.description,
                                    value: param.valueString != "" ? spaceStore.spaces[param.valueString!]!.title : "") {
                                    model.open(paramResponse: param)
                                }
                            }
                                
                            if param.type == .DEADLINE_RELATIVE_DATE {
                                EditViewChooseLineItem(
                                    title: param.type!.description,
                                    value: param.valueString!) {
                                    model.open(paramResponse: param)
                                }
                            }
                            
                        }
                        
                    }
                    
                    VStack{
                        Button {
                            DispatchQueue.main.async {
                                viewUserStore.openChooseParamToAddSheet(addParam: self.model.addParamCallback)
                            }
                        } label: {
                            VStack{
                                HStack{
                                    Spacer()
                                    Text("Add param")
                                        .foregroundColor(SolColor.colors().fontColors.normal)
                                        .font(SolFonts.font(size: 14, weight: Font.Weight.bold, color: SolColor.colors().fontColors.normal))
                                    Spacer()
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer().frame(height: 150)
                    }
                    .listRowSeparator(Visibility.hidden)
                    .listRowBackground(SolColor.colors().screen.background)
                }

            }
            .listStyle(PlainListStyle())
            .background(SolColor.colors().screen.background)
            .ignoresSafeArea(.all)
            
                       
            
            if model.bottomButtonType == BottomButtonType.CLOSE_ICON_FIELD {
                DoneKeyboardButtonView(action: {                   
                    model.bottomButtonType = BottomButtonType.ADD_TASK
                    addTaskModel.state = .HIDDEN
                    self.model.stopEditIcon = true
                })
            }else{
                VStack{
                    Spacer()
                    HStack{
                        if self.model.viewUserEntity.canEdit == true {
                            Spacer()
                            if self.model.createMode == false {
                                Button {
                                    self.model.delete()
                                    self.presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text("Delete")
                                        .font(SolFonts.font(size: 20.0, weight: Font.Weight.medium, color: SolColor.colors().button.font))
                                        .foregroundColor(SolColor.colors().button.font)
                                }
                                .padding()
                                .background(SolColor.colors().button.background)
                                .foregroundColor(SolColor.colors().button.background)
                                .cornerRadius(8.0)
                                
                                Spacer().frame(width: 50, height: 1)
                            }
                            
                            
                            
                            Button {
                                self.model.save()
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text(self.model.createMode == true ? "Create" : "Update")
                                    .font(SolFonts.font(size: 20.0, weight: Font.Weight.medium, color: SolColor.colors().button.font))
                                    .foregroundColor(SolColor.colors().button.font)
                            }
                            .padding()
                            .background(SolColor.colors().button.background)
                            .foregroundColor(SolColor.colors().button.background)
                            .cornerRadius(8.0)
                            
                            Spacer()
                        } else {
                            Spacer()
                            Text("You cannot edit this view. You can only hide view.")
                            Spacer()
                        }
                        
                    }
                    
                    
                    Spacer().frame(height: 44.0)
                }
            }
            
        }.toast(isPresenting: $model.showToast){
            AlertToast(
                displayMode: .hud,
                type: .regular,
                title: model.toastTitle,
                subTitle: model.toastSubtitle
            )
        }
        
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .preferredColorScheme(.light)
        .navigationTitle("Edit SmartView")
        .navigationBarHidden(false)
        
        .onAppear(perform: {
            self.addTaskModel.state = .HIDDEN
            
            self.model.spaceId = ""
            self.model.taskId = ""
            
            self.model.store = viewUserStore
            self.model.spaceStore = spaceStore
            
            if self.isCreate == true {
                self.model.initCreate()
            }else{
                self.model.initEdit(viewId: self.viewId!)
            }
            
            self.model.confCallback(viewUserStore: self.viewUserStore)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.model.emoji = self.model.viewUserEntity.view!.icon!.data!
            }
        })
        .onDisappear {
            
        }
    }
}




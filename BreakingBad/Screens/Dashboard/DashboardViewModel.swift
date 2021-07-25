//
//  DashboardViewModel.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import Foundation

struct DashboardScreenStaticInfo {
    var title: String
    var image: String
    var action: () -> Void
}

class DashboardViewModel: DashboardViewModelType {
    var title: String = "Dashboard"
    
    struct ActionHandler {
        let showCharacters: () -> Void
        let showEpisodes: () -> Void
        let showQuotes: () -> Void
    }
    
    var dashboardContent: [DashboardScreenStaticInfo] = []
    
    private let actionHandler: ActionHandler
    
    init(actionHandler: ActionHandler) {
        self.actionHandler = actionHandler
        dashboardContent = [.init(title: "Characters", image: "characters", action: actionHandler.showCharacters),
                            .init(title: "Episodes", image: "episodes", action: actionHandler.showEpisodes),
                            .init(title: "Quotes", image: "quotes", action: actionHandler.showQuotes)]
    }
    
    func getDataCount() -> Int {
        return dashboardContent.count
    }
    
    func getCellDataAt(index: Int) -> DashboardScreenStaticInfo {
        return dashboardContent[index]
    }
    
    func handleAction(index: Int) {
        dashboardContent[index].action()
    }
}

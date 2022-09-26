//
//  DocumentPreviewViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import Foundation

class DocumentPreviewViewModel {
    // MARK: Navigation
    var onPreviousScreen: (() -> Void)?
    var onSaveFile: (([Any]) -> Void)?
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

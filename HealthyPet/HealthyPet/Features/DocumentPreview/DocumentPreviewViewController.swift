//
//  DocumentPreviewViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import UIKit
import WebKit

class DocumentPreviewViewController: UIViewController {
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveDocumentButton: UIButton!
    
    var viewModel: DocumentPreviewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = viewModel else { return }
        
        let req = NSMutableURLRequest(url: viewModel.url)
        req.timeoutInterval = 60.0

        webView.load(req as URLRequest)
        configureUI()
    }
    
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight24
        titleLabel.textColor = Theme.Colors.black
        saveDocumentButton.titleLabel?.font = Theme.Fonts.openSansBold16
        saveDocumentButton.setTitleColor(Theme.Colors.blue, for: .normal)
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackButton)))
    }
    
    @IBAction private func didTapSaveDocumentButton(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        
        var filesToShare = [Any]()

        // Add the path of the file to the Array
        filesToShare.append(viewModel.url)
        
        viewModel.onSaveFile?(filesToShare)
    }
    
    @objc private func didTapBackButton() {
        viewModel?.onPreviousScreen?()
    }
}

extension DocumentPreviewViewController: StoryboardController {
    static var storyboard: Storyboard {
        .Main
    }
}

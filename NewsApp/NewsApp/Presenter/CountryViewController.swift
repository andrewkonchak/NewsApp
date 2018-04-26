//
//  CountryViewController.swift
//  NewsApp
//
//  Created by Andrew on 4/25/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

protocol CountryViewControllerDelegate: class {
    
    func didSelectCountry(_ country: NewsCountry)
    
}

class CountryViewController: UIViewController {
    
    weak var delegate: CountryViewControllerDelegate?
    
    @IBAction func didPressCountry(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text,
            let country = NewsCountry(with: text) else {
                return
        }
        
        delegate?.didSelectCountry(country)
        dismiss(animated: true, completion: nil)
    }

}

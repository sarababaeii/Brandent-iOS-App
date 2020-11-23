//
//  DiseasesViewController.swift
//  Brandent
//
//  Created by Sara Babaei on 10/28/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class DiseaseViewController: UIViewController {
   
    @IBOutlet weak var diseasesTableView: UITableView!
    
    var diseasesTableViewDelegate: DiseasesTableViewDelegate?
    
    func setDelegates() {
        diseasesTableViewDelegate = DiseasesTableViewDelegate()
        diseasesTableView.delegate = diseasesTableViewDelegate
        diseasesTableView.dataSource = diseasesTableViewDelegate
    }
    
    func configure() {
        setDelegates()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "بیماری‌ها", style: UIBarButtonItem.Style.plain, target: self, action: .none)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Vazir-Bold", size: 26.0)!], for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure()
    }
}

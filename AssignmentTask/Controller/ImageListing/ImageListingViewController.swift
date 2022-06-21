//
//  ImageListingViewController.swift
//  AssignmentTask
//
//  Created by SAIKAT GHOSH on 21/06/22.
//

import UIKit

class ImageListingViewController: UIViewController {
    
    @IBOutlet weak var tablevwImageList: UITableView!
    var responseArray = [DataModel]()
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}

//
//  ImageListing + Extensions.swift
//  AssignmentTask
//
//  Created by SAIKAT GHOSH on 21/06/22.
//

import UIKit
import Alamofire
import AlamofireImage



extension ImageListingViewController {
    
    func setupUI(){
        
        self.tablevwImageList.register(ImageListingTableCell.nib,
                                       forCellReuseIdentifier: ImageListingTableCell.identifier)
        
        
        self.tablevwImageList.dataSource = self
        self.tablevwImageList.delegate = self
        self.tablevwImageList.prefetchDataSource = self
        
        self.tablevwImageList.estimatedRowHeight = 200
        self.tablevwImageList.rowHeight = UITableView.automaticDimension
        
        self.populateDataInTableView()
        
        
    }
    
    
    func populateDataInTableView() {
        APIManager.sharedInstance.requestApiWithUrlString(apiAddress: "https://picsum.photos/v2/list?page=1&limit=100", param: "", requestType: "GET") { (dictResponse, error, success) in
            
            if success {
                self.responseArray = dictResponse
                
                DispatchQueue.main.async {
                    self.tablevwImageList.reloadData()
                }
            }  else {
                debugPrint("Something went wrong...")
            }
        }
    }
    
}

extension ImageListingViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        ImageListingTableCell.identifier, for: indexPath) as? ImageListingTableCell
        {
            cell.imgView.image = nil
            
            
            if let imageFromCache = imageCache.object(forKey: String(responseArray[indexPath.row].download_url ?? "") as AnyObject) as? UIImage {
                cell.imgView.image = imageFromCache
                debugPrint("image coming from cache")
            }else {
                AF.request(String(responseArray[indexPath.row].download_url ?? "")).responseImage { [self] response in
                    if case .success(let image) = response.result {
                        cell.imgView.image = image
                        imageCache.setObject(image, forKey: String(responseArray[indexPath.row].download_url ?? "") as AnyObject)
                        
                        debugPrint("image downloading from url")
                    }
                }
            }
            return cell
            
        }
        return UITableViewCell()
    }
}
//MARK: TableView Prefetch Data Source
extension ImageListingViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        debugPrint("prefetchRowsAt : \(indexPaths)")
    }
              
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        debugPrint("cancelPrefetchingForRowsAt \(indexPaths)")
    }
}

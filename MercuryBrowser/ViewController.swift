//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let images = [UIImage(named: "mercury"), UIImage(named: "freddy")]
    let urlString = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"

 
    
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        if let url = URL(string: urlString){
            
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: request) {(data, response, error) in
                //the data type just handles blobs of data
                let cellList = try! JSONDecoder().decode(CellList.self, from: data!)
                for cell in cellList.mercury{
                    print(cell.url)

                }
          
            }
            
            task.resume()
        }


    }


}

    


extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell")!
        let image = images[indexPath.item]
        
        
        
        if let photoCell = cell as? PhotoCell{
            photoCell.cellImage.image = image
        }

        
  
        return cell
        
        
    }
    
    
}


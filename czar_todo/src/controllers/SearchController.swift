//
//  ViewController.swift
//  czar_todo
//	//  Created by aluno on 11/10/22.
//

import UIKit

class SearchController: UIViewController {
    @IBOutlet weak var inputRef: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func doSearch() {
        guard let value = inputRef.text else { return }
        
        if (value == "") {
            return
        }
        
        let details = self.storyboard?.instantiateViewController(withIdentifier: "Details") as! DetailsController
        
        details.searchValue = value
        print("navigating searchValue \(details.searchValue)")
        
        self.navigationController?.pushViewController(details, animated: true)
    }

    // create a method that 
    
    @IBAction func searchOnEnter(_ sender: Any) {
        doSearch()
    }
    
    @IBAction func onButtonPress(_ sender: Any) {
        doSearch()
    }
}


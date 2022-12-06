//
//  DetailsController.swift
//  czar_todo
//
//  Created by aluno on 25/10/22.
//

import UIKit
import Foundation
import Alamofire

class DetailsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var titleRef: UILabel!
    @IBOutlet weak var subtitleRef: UILabel!
    @IBOutlet weak var inputRef: UITextField!
    @IBOutlet weak var meaningsTableRef: UITableView!
    
    var word: Word!
    var searchValue: String = ""
    var meanings:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.meaningsTableRef.dataSource = self
        self.meaningsTableRef.delegate = self
        self.titleRef.text = "carregando..."
        self.subtitleRef.text = "carregando..."
        
        let api = HttpClient()
        print("search is " + self.searchValue)
        
        api.getJSON(url: self.searchValue, parameters: nil, callback: {
            (result) in
            
            self.titleRef.text = self.searchValue
            self.subtitleRef.text = result?.etymology ?? ""
            self.meanings = result?.meanings ?? []
            self.meaningsTableRef.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meanings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MeaningTableViewCell", owner: self, options: nil)?.first as! MeaningTableViewCell
        let name = self.meanings[indexPath.row]
        cell.labelRef.text = name
        
        return cell
    }
    
    func doSearch() {
        self.titleRef.text = "carregando..."
        self.subtitleRef.text = "carregando..."
        self.meanings = []
        self.meaningsTableRef.reloadData()
        
        let api = HttpClient()
        self.searchValue = inputRef.text ?? ""
        print("search is " + self.searchValue        )
        
        api.getJSON(url: self.searchValue, parameters: nil, callback: { (result) in
            self.titleRef.text = self.searchValue
            self.subtitleRef.text = result?.etymology ?? ""
            self.meanings = result?.meanings ?? []
            self.meaningsTableRef.reloadData()
        })
    }
    
    @IBAction func onPressEnter(_ sender: Any) {
        doSearch()
    }
    @IBAction func searchWord(_ sender: Any) {
        doSearch()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  MCU
//
//  Created by mazen moataz on 04/11/2021.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var charsTableView: UITableView!
    var globalChars:CharacterDataResult?
    override func viewDidLoad() {
        charsTableView.dataSource = self
        charsTableView.delegate = self
        let m = MarvelData()
        super.viewDidLoad()
        let params = ["limit": 100, "offset": 1]
        m.request(with: "/v1/public/characters?", parameters: params, method: .get) { data in
            self.globalChars = try? JSONDecoder().decode(CharacterDataResult.self, from: data)
            DispatchQueue.main.async {
                self.charsTableView.reloadData()
            }
           print(self.globalChars?.data.results.count ??  "error while fetching chars data")
        } failure: { error in
            print(error.localizedDescription)
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let chars = globalChars{
            return chars.data.results.count
        }else{
            return 1
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charCell") as! CellControllerTableViewCell
        cell.name.text = globalChars?.data.results[indexPath.row].name
        let charDesc = globalChars?.data.results[indexPath.row].description
        if charDesc != "" {
            cell.desc.text = charDesc
        }else{cell.desc.text =  "no description for this character"}
        setCharImg(tableView: charsTableView, tableViewCell: cell,indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToCharDetails", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "goToCharDetails"{
            var comicsItems = [ComicSummary]()
            var comicsNames = [String]()
            let indexPath = sender as! IndexPath
            let charDetailVC = segue.destination as! CharacterDetails
            charDetailVC.navigationItem.title = globalChars?.data.results[indexPath.row].name
            let imgUrlHttp = "\(globalChars?.data.results[indexPath.row].thumbnail.path ?? "no image path")/detail.\(globalChars?.data.results[indexPath.row].thumbnail.extension ?? "no image extension")" // http image url
            let imgURL = URL(string: "https\(imgUrlHttp.dropFirst(4))")  // replaces http with https and converts String into URL
            if let safeUrl = imgURL{
            let data = try! Data(contentsOf: safeUrl)
                DispatchQueue.main.async {
                    charDetailVC.charDetailsImg.image = UIImage(data: data)
                }
            }
           // let count = (globalChars?.data.results[indexPath.row].comics.returned)!
            DispatchQueue.global().async {
                comicsItems = (self.globalChars?.data.results[indexPath.row].comics.items)!
                for i in comicsItems{
                    comicsNames.append(i.name) // adding all hero's comics names in one array of strings to join tham and generate one string
                }
            }
            DispatchQueue.main.async {
                if self.globalChars?.data.results[indexPath.row].description != "" {
                    charDetailVC.CharacterDetailsDesc.text = self.globalChars?.data.results[indexPath.row].description
                }else{
                    charDetailVC.CharacterDetailsDesc.text = "this character doesn't have description"
                }
                charDetailVC.CharacterAvailableStories.text =  "\((self.globalChars?.data.results[indexPath.row].comics.available)!)"
                charDetailVC.CharacterStroiesNames.text = comicsNames.joined(separator: "\n")
            }
        }
    }
    func setCharImg(tableView : UITableView,tableViewCell:CellControllerTableViewCell,indexPath: Int){
        let imgUrlHttp = "\(globalChars?.data.results[indexPath].thumbnail.path ?? "no image path")/portrait_small.\(globalChars?.data.results[indexPath].thumbnail.extension ?? "no image extension")"
        let imgURL = URL(string: "https\(imgUrlHttp.dropFirst(4))")  // replaces http with https and converts String into URL
        if let safeUrl = imgURL{
        let data = try! Data(contentsOf: safeUrl)
            DispatchQueue.main.async {
                tableViewCell.charImage?.image = UIImage(data: data)
            }
        }
        print(imgURL ?? "url is nil")
    }
}




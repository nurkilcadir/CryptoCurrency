//
//  ViewController.swift
//  CyryptoCrazy
//
//  Created by Nur on 25.02.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListViewModel!
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.colorArray = [
            UIColor(red: 75/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 15/255, green: 28/255, blue: 100/255, alpha: 1.0),
            UIColor(red: 30/255, green: 80/255, blue: 38/255, alpha: 1.0),
            UIColor(red: 7/255,  green: 79/255, blue: 88/255, alpha: 1.0),
            UIColor(red: 67/255, green: 80/255, blue: 90/255, alpha: 1.0),
            UIColor(red: 85/255, green: 100/255, blue: 75/255, alpha: 1.0)
        ]
        
        getData()
    }
    
    
    func getData(){
        let url = URL(string: "https://github.com/atilsamancioglu/K21-JSONDataSet/blob/master/crypto.json")
        
        Webservice().downloadCurrencies(url: url!) { (cryptos) in
            if let cryptos = cryptos{
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
            let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
            
            cell.currencyText.text = cryptoViewModel.name
            cell.priceText.text = cryptoViewModel.price
            cell.backgroundColor = self.colorArray[indexPath.row % 6]
            
            return cell
            
        }
    }



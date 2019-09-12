//
//  ViewController.swift
//  stopWacth02
//
//  Created by 田中陽子 on 2019/09/08.
//  Copyright © 2019 Yoko Tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //呼び出しやすいように省略型を書く
    let userDefaults = UserDefaults.standard
    let key = "count11"
    
    //取り出されるときは値が入っていますので、どうかオプショナルの私を普通の変数として取り扱ってください
    //  暗黙的アンラップ
//    var count : Int! {
//        didSet {self.setCountLabel(count: <#Int#>)}
////    }

    var counter = 0.0
    var timer = Timer()
    var isPlaying:Bool  = false //Bool型
    
    var addLap:Bool = false
    
    var laps:[String] = []
    var stopwatchString:String = ""

    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(counter)
        stopBtnOutlet.isEnabled = false
//Integerをとるときの書き方（ただし、ない場合はないという情報でなく、0が返ってくる）
            let saveValue = userDefaults.integer(forKey: key)
            counter = Double(saveValue)
    }

    
    @IBOutlet weak var startBtnOutlet: UIButton!
    @IBOutlet weak var stopBtnOutlet: UIButton!
    @IBOutlet weak var lapBtnOutlet: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    
    @IBAction func startBtn(_ sender: Any) {
        if(isPlaying) {return}
        startBtnOutlet.isEnabled = false // ボタン無効
        stopBtnOutlet.isEnabled = true // ボタン有効
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
        addLap = true
    }
    
    @IBAction func stopBtn(_ sender: Any) {
        startBtnOutlet.isEnabled = true
        stopBtnOutlet.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        addLap = false

    }
    
    @IBAction func resetBtn(_ sender: Any) {
        startBtnOutlet.isEnabled = true
        stopBtnOutlet.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        addLap = false
        counter = 0.0
        countLabel.text = String(counter)
        
    }
    
    @IBAction func lapBtn(_ sender: Any) {
        if addLap == true{
            laps.insert(stopwatchString, at: 0)
            lapsTableView.reloadData()
            
        }
        
    }
    
    
    //    関数
    @objc func UpdateTimer(){
            counter = counter + 0.1
            countLabel.text = String(format: "%.1f", counter)
                }

 //    Table View Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = UIColor.yellow
        cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"//上に追記されるように
        cell.detailTextLabel?.text = laps[indexPath.row]  //"0.0"出ない
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
        
    }
    
    
    
    
    
}






    


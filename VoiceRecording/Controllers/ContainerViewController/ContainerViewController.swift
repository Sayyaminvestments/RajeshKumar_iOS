//
//  ContainerViewController.swift
//  VoiceRecording
//
//  Created by Sayyam on 13/04/23.
//

import UIKit

class ContainerViewController: BaseHelper,UITableViewDataSource,UITableViewDelegate{
    
    // @IBOutlet
    @IBOutlet weak var table: UITableView!
    
    // variables
    var networkManager = SentanceListManger()
    var isWaiting = "waiting"
    var listModel = [ListArray]()
    var titleName = ""
    var sentance_no = ""
    var item: ListArray?
    
    var current_page = 20
    
    let refreshControl = UIRefreshControl()
    
    // view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pull refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table.addSubview(refreshControl) // not required when using UITableViewController
        
        
        startLoader()
        networkManager.sentanceListApi(isWaiting: isWaiting,pageNo: current_page) { resultData, error in
            DispatchQueue.main.async {
                if let listmdl = resultData {
                    self.listModel.removeAll()
                    self.stopLoader()
                    if let listArray = listmdl.data?.list {
                        self.listModel.append(contentsOf: listArray)
                        
                        self.table.reloadData()
                    }
                }
            }
            
        }
        
        table.dataSource = self
        table.delegate = self
    }
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        print("hello pull refresh")
        networkManager.sentanceListApi(isWaiting: isWaiting,pageNo: current_page) { resultData, error in
            DispatchQueue.main.async {
                if let listmdl = resultData {
                    self.listModel.removeAll()
                    self.stopLoader()
                    if let listArray = listmdl.data?.list {
                        self.listModel = listArray
                        
                        self.table.reloadData()
                        self.refreshControl.attributedTitle = NSAttributedString(string: "Refresh Success")
                        self.refreshControl.endRefreshing()
                    }
                }
            }
            
        }
    }
    //MARK: Tableview Data Source & Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let item = listModel[indexPath.row]
        cell.titleLabel.text = item.text
        if item.hasAudio == true {
            cell.phoneNoLabel.isHidden = true
            cell.greenImage.image = UIImage(named: "finished")
        } else {
            cell.greenImage.isHidden = true
            cell.phoneNoLabel.isHidden = false
            cell.phoneNoLabel.text = "Start Record"
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let index = listModel[indexPath.row].index {
            if current_page < index+1 && indexPath.row == listModel.count - 1 {
                current_page = current_page + 20
                loadTable()
            }
        }
    }
    func loadTable() {
        startLoader()
        networkManager.sentanceListApi(isWaiting: isWaiting,pageNo: current_page) { resultData, error in
            DispatchQueue.main.async {
                if let listmdl = resultData {
                    self.listModel.removeAll()
                    self.stopLoader()
                    if let listArray = listmdl.data?.list {
                        self.listModel.append(contentsOf: listArray)
                        
                        self.table.reloadData()
                    }
                }
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.item = listModel[indexPath.row]
        if item?.hasAudio == true {
            
            let alertVC = self.storyboard!.instantiateViewController(withIdentifier: "SpeechRecordFinishedAlertVC") as! SpeechRecordFinishedAlertVC
            alertVC.delegate = self
            alertVC.view.frame = CGRect(x: -20, y: -200, width: view.frame.width+35, height: view.frame.height+350)
            self.view.addSubview(alertVC.view)
            alertVC.didMove(toParent: self)
            self.addChild(alertVC)
            
        } else {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "SpeedRecordDetailVC") as! SpeedRecordDetailVC
            controller.listModel = item
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

// Delegate
extension ContainerViewController: SpeechRecordDelegate {
    func speechRecordDetailVC() {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "SpeedRecordDetailVC") as! SpeedRecordDetailVC
        controller.listModel = item
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

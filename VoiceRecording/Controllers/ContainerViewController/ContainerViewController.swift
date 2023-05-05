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
    
    // view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
       //startLoader()
        networkManager.sentanceListApi(isWaiting: isWaiting) { resultData, error in
            DispatchQueue.main.async {
            if let listmdl = resultData {
               // self.stopLoader()
                if let listArray = listmdl.data?.list {
                    self.listModel = listArray
                    print("resultData====",self.listModel)
                    
                        self.table.reloadData()
                    }
                }
            }
            
        }
        table.dataSource = self
        table.delegate = self
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.item = listModel[indexPath.row]
        if item?.hasAudio == true {
           
            let alertVC = self.storyboard!.instantiateViewController(withIdentifier: "SpeechRecordFinishedAlertVC") as! SpeechRecordFinishedAlertVC
            alertVC.delegate = self
            self.present(alertVC, animated: true)
           
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

//
//  ContainerViewController.swift
//  VoiceRecording
//
//  Created by Sayyam on 13/04/23.
//

import UIKit

class ContainerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
    var networkManager = SentanceListManger()
    var listModel = [ListArray]()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.sentanceListApi { resultData, error in
            if let listmdl = resultData {
                if let listArray = listmdl.data?.list {
                    self.listModel = listArray
                    print("resultData====",self.listModel)
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
            }
            
        }
        table.dataSource = self
        table.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let item = listModel[indexPath.row]
        cell.titleLabel.text = item.text
        cell.phoneNoLabel.text = "Start Record"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "SpeedRecordDetailVC") as! SpeedRecordDetailVC
        if let title = listModel[indexPath.row].text {
            controller.titleName =  title
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

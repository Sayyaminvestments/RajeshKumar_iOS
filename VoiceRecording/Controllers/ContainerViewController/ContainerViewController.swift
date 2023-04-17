//
//  ContainerViewController.swift
//  VoiceRecording
//
//  Created by Sayyam on 13/04/23.
//

import UIKit

class ContainerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.titleLabel.text = "Rajesh kumar Ranchi Jharkhand"
        cell.phoneNoLabel.text = "Start Record"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "SpeedRecordDetailVC") as! SpeedRecordDetailVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

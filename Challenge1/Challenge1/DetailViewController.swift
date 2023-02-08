//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Austin Chiu on 2023/2/2.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var flagImage: UIImageView!
    var Country: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let country = Country {
            flagImage.image  = UIImage(named: country)
            title = country.count <= 2 ? country.uppercased() : country.capitalized
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.largeTitleDisplayMode = .never
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func shareTapped() {
        guard let image = flagImage.image else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

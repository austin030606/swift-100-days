//
//  DetailViewController.swift
//  Project1
//
//  Created by Austin Chiu on 2023/1/30.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var rowIndex: Int?
    var total: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
        if let indexNum = rowIndex, let totalNum = total {
            title = "\(indexNum + 1) of \(totalNum)"
        } else {
            title = "invalid"
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let imageFilename = selectedImage else {
            print("No image found")
            return
        }
        
        let imageFilenameComponents = imageFilename.components(separatedBy: ".")
        
        if let filePath = Bundle.main.path(forResource: imageFilenameComponents[0], ofType: imageFilenameComponents[1]) {
            let url = URL(fileURLWithPath: filePath)
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        }
    }
}

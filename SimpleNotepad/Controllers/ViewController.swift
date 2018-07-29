//
//  ViewController.swift
//  SimpleNotepad
//
//  Created by Krystian Bujak on 29/07/2018.
//  Copyright © 2018 Krystian Bujak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    private let fileName = "text.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
                let content = try String(contentsOf: url.appendingPathComponent(fileName))
                textView.text = content
            }
        }catch{
            textView.text = ""
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName){
            do{
                try textView.text.write(to: path, atomically: true, encoding: .utf8)
            }catch{
                let alertViewController = UIAlertController(title: "Error", message: "Could not write to file", preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertViewController, animated: true)
            }
        }
    }
}


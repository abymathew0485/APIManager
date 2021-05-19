//
//  ViewController.swift
//  APIManager
//
//  Created by Aby Mathew on 19/05/21.
//

import UIKit

class ViewController: UIViewController {

    var postsServies: PostsServices?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       postsServies = PostsServices()
    }
    
    private func fetchPosts(){
        
        print("fetch stating....")
        postsServies?.fetchAllPosts(completion: { (result) in
            
            switch result {
            case .success(let posts):
                for post in posts {
                    print(post.title ?? "No title", post.body ?? "No body")
                }
            case .failure(let error):
                print("error - \(error.localizedDescription)")
            }
        })
        
    }
    
    @IBAction func startFetchAction(_ sender: Any) {
        fetchPosts()
    }
    


}


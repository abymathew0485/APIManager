//
//  ViewController.swift
//  APIManager
//
//  Created by Aby Mathew on 19/05/21.
//

import UIKit

class ViewController: UIViewController {

    var postsServies: PostsServices?
    var serviceLayer: ServiceLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       postsServies = PostsServices()
        serviceLayer = ServiceLayer() // Avoide this dependency using Interfaces abstraction.
    }
        
    // MARK: - IBActions
    @IBAction func startFetchAction(_ sender: Any) {
        fetchPosts()
    }
    
    @IBAction func fetchCommetsAction(_ sender: Any) {
        fetchAllComments()
    }
    
}

extension ViewController {
    
    fileprivate func fetchPosts(){
        
        debugPrint("fetch posts starting....")
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
    
    fileprivate func fetchAllComments(){
        debugPrint("fetch comments starting....")
        serviceLayer?.fetchAllComments(completion: { (result) in
            
            switch result {
            case .success(let comments):
                for comment in comments {
                    print("\n\n title : \(comment.name ?? "no name") \n email : \(comment.email ?? "no email") \n commet: \(comment.body ?? "No comment")")
                }
            case .failure(let error):
                print("error - \(error.localizedDescription)")
            }
        })
    }
}

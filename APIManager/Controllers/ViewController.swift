//
//  ViewController.swift
//  APIManager
//
//  Created by Aby Mathew on 19/05/21.
//

import UIKit

class ViewController: UIViewController {

    var serviceLayer: ServiceLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        serviceLayer = ServiceLayer(apiClient: LocalDataClient()) // dependency inversion using networkclient adding. So we can use anytype of apiclient which confirm ApiClientProtocol.
    }
        
    // MARK: - IBActions
    @IBAction func startFetchAction(_ sender: Any) {
        fetchLocalDataFromBundle()
//        fetchPosts()
    }
    
    @IBAction func fetchCommetsAction(_ sender: Any) {
//        fetchAllComments()
    }
    
}

extension ViewController {
    
    // MARK: - Fetch all POSTS
    fileprivate func fetchPosts(){
        
        debugPrint("fetch posts starting....")
        serviceLayer?.fetchAllPosts(completion: { (result) in
            
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
    // MARK: - Fetch all COMMENTS
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
    
    // MARK: - Local Data Fetching
    fileprivate func fetchLocalDataFromBundle(){
        debugPrint("fetch data from Local Bundle file starting....")
        let postsAPIRequest = PostApiRequest()
        serviceLayer?.fetchData(apiRequest: postsAPIRequest, completion: { (result: Result<[Post],NetworkError>) in
            
            switch result {
            case .success(let posts):
                for post in posts {
                    print("\n\n name : \(post.title ?? "no name") \n designation : \(post.body ?? "no designation")")
                }
            case .failure(let error):
                print("error - \(error.localizedDescription)")
            }
        })
    }
    
}

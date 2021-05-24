//
//  ViewController.swift
//  APIManager
//
//  Created by Aby Mathew on 19/05/21.
//

import UIKit

class ViewController: UIViewController {

    var service: APIService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // dependency inversion using networkclient adding. So we can use anytype of apiclient which confirm ApiClientProtocol.
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
    
    // MARK: - Fetch all POSTS
    fileprivate func fetchPosts(){
        
        service = ServiceAdapter(request: PostApiRequest()).retry(5)
        debugPrint("fetch posts starting....")
        service?.makeApiCall(completion: { (result: Result<[Post], NetworkError>) in
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
        service = ServiceAdapter(request: CommentsApiRequest()).retry(5)
        debugPrint("fetch comments starting....")
        service?.makeApiCall(completion: { (result: Result<[Comment], NetworkError>) in
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

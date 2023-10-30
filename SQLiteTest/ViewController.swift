//
//  ViewController.swift
//  SQLiteTest
//
//  Created by Naw Su Su Nyein on 29/10/2023.
//

import UIKit

class ViewController: UIViewController {

    var blogList : [Blog] = []
    var BLOG = "blog"
    var TITLE = "title"
    var CONTENTS = "contents"
    var PRICE = "price"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let queryString = "CREATE TABLE IF NOT EXISTS \(BLOG)" +
        "(\(TITLE) TEXT," +
        "\(CONTENTS) TEXT," +
        "\(PRICE) INT)"
        LocalStorageManager().createTable(queryString: queryString)
        
       // createMockBlog()
        getBlogList()
       // deleteBlog()
        
      //  updateBlog()
    }


    func createMockBlog() {
        for i in 0..<100 {
            let title = "title \(i)"
            let contents = "When I first began learning Japanese in 2036, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2020, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade. \(i)"
            let price = i
            let blogObj = Blog(title: title, contents: contents, price: Int32(price))
            blogList.append(blogObj)
        }
        //createUserList()
        let queryString = "INSERT INTO \(BLOG) " +
            "(\(TITLE)," +
            "\(CONTENTS)," +
            "\(PRICE)) VALUES(?,?,?)"
        
        LocalStorageManager().insert(blogList: blogList, queryString: queryString, completionError: {_ in }, readyInsertion: {_ in
            
        })
    }
    
    func getBlogList() {
        let queryString = "SELECT * FROM \(BLOG)";
        LocalStorageManager().getData(queryString: queryString, completion: {dataList in
            for value in dataList ?? [] {
                let stringValue = String(describing: value)
                print(stringValue)
            }
        }, completionError: {errorMessage in
            print("retrieving error : \(errorMessage)")
        })
    }
    
    func deleteBlog() {
        let title = "'title 2'"
        //let queryString = "DELETE FROM \(BLOG) WHERE title = \(title)"
        let queryString = "DELETE FROM \(BLOG)"
        print("query : \(queryString)")
        LocalStorageManager().deleteData(queryString: queryString, completion: {_ in

        }, completionError: {error in
            
        })
    }
    
    func updateBlog() {
        let queryString = "UPDATE \(BLOG) SET \(TITLE) = 'one sui' WHERE \(TITLE) = 'title 1'"
        LocalStorageManager().updateData(queryString: queryString, completion: {_ in
            print("updated successfully")
        }, completionError: {error in })
    }
}


struct Blog {
    let title : String
    let contents : String
    let price : Int32
}

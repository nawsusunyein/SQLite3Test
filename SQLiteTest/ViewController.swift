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
    var students : [Students] = []
    
    var objectArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let queryString = "CREATE TABLE IF NOT EXISTS \(BLOG)" +
//        "(\(TITLE) TEXT," +
//        "\(CONTENTS) TEXT," +
//        "\(PRICE) INT)"
//        LocalStorageManager().createTable(queryString: queryString)
        
       // createMockBlog()
      //  getBlogList()
       // deleteBlog()
        
      //  updateBlog()
       // testString()
       // getJSONString()
        //testJsonFromFile()
        let student1 = Students(name: "mg mg", age: 12, city: "Yangon")
        let student2 = Students(name: "hal", age: 13, city: "Yangon")
        let student3 = Students(name: "tha", age: 14, city: "Yangon")
        let student4 = Students(name: "gya", age: 12, city: "Yangon")
        let student5 = Students(name: "mya", age: 11, city: "Yangon")
        let student6 = Students(name: "hinn", age: 11, city: "Yangon")
        students.append(student1)
        students.append(student2)
        students.append(student3)
        students.append(student4)
        students.append(student5)
        students.append(student6)
        
        let studentsByAge = Dictionary(grouping: students, by: {$0.age})
        print("test : \(studentsByAge)")
        print("1 : \(studentsByAge[13])")
        let grouped = students.reduce([Int:[Students]]()) { (res, box) -> [Int:[Students]] in
            var res = res
            res[box.age] = (res[box.age] ?? []) + [box]
            return res
        }
        for (key, value) in grouped {
            objectArray.append(Objects(studentId: key, students: value))
        }
        
        print("group by age : \(objectArray[0].studentId)")
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
    
    func testString() {
        var aValue = "\"3 \n hello \""
        let preparedString = aValue.replacingOccurrences(of: "\n", with: "\\n")
        let  jsonData = preparedString.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)

        if let str = json as? String {
            print(str) // 3
        }
        
    }
    
    func getJSONString() {
        
        var urlString = "https://github.com/nawsusunyein/JapaneseBasicVocab/blob/master/testdata.json"
        var request = URLRequest(url: URL(string : urlString)!)               //Requestを生成
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])  // DataをJsonに変換
                print(object)
            } catch let error {
                print(error)
            }
        }
        task.resume()
        
    }
    
    func testJsonFromFile() {
        if let path = Bundle.main.path(forResource: "testmodel", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
                let modelString = String(data: data, encoding: .utf8)
                let preparedString = modelString?.replacingOccurrences(of: "\n", with: "")
                let preparedData = Data(preparedString!.utf8)
                print("model string : \(modelString)")
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
                 if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            // do stuff
                     if let couponList = jsonResult["coupon:loop"] as? [[String : String]] {
                         print("coupon list : \(couponList)")
                     }
                     print("** here blah")
                 } else {
                     print("** here here noh")
                 }
              } catch {
                   // handle error
                  print("** here error")
              }
        } else {
            print("** here")
        }
    }
}


struct Blog {
    let title : String
    let contents : String
    let price : Int32
}

struct Students  {
    let name : String
    let age : Int
    let city : String
}


struct Objects {
    let studentId : Int
    let students : [Students]
}

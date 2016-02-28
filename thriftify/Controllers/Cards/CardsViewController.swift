//
//  CardsViewController.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 2/14/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit
import AlecrimCoreData
import CoreData

class CardsViewController: UIViewController, UICollectionViewDataSource {
    let dataContext = DataContext()
    var cards = [TFCard]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        self.cards = dataContext.tfcards.toArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Card", forIndexPath: indexPath)
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    func configureCell(cell: UICollectionViewCell, atIndexPath indexPath: NSIndexPath) {
        let card = cards[indexPath.row]
        if let cardCell = cell as? CardViewCell {
            
            if let _ = card.number {
                cardCell.number.text = card.strarredNumber
            }

            if let cholder = card.cardholder {
                cardCell.cardholder.text = cholder as String
            }
        }
    }
}

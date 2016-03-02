//
//  CardsDetailViewController.swift
//  thriftify
//
//  Created by Vitalij on 29.02.16.
//  Copyright © 2016 vt. All rights reserved.
//

import Foundation
import AlecrimCoreData
import CoreData

class CardsDetailViewController: UICollectionViewController {
    let dataContext = DataContext()
    var cards = [TFCard]()
    
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
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return cards.count
    }
    
    
    //CollectionView
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardViewCell", forIndexPath: indexPath)
        
        if let mycell = cell as? CardCollectionViewCell {
            let card = cards[indexPath.section]
            mycell.cardView.configureCell(card)
            
            return mycell
        }
        
        return cell
    }
}



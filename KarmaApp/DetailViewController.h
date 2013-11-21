//
//  DetailViewController.h
//  MasterDetailExample
//
//  Created by Samuel Stine on 11/10/13.
//  Copyright (c) 2013 Sam Stine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

//helo

//
//  ViewController.h
//  Mi primera tabla
//
//  Created by VirtualBox on 9/20/17. 
//  Copyright © 2017 VirtualBox. All rights reserved. 
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableMain;

-(void) addCellWithName:(NSString*)name withAge:(NSString*)age withDescription:(NSString*)description andImage:(UIImage*) image;

@end


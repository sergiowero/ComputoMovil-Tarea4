//
//  cellMainTable.h
//  Mi primera tabla
//
//  Created by VirtualBox on 9/20/17.
//  Copyright © 2017 VirtualBox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellMainTable : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;

@end

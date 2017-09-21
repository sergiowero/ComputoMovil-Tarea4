//
//  ViewController.m
//  Mi primera tabla
//
//  Created by VirtualBox on 9/20/17.
//  Copyright © 2017 VirtualBox. All rights reserved.
//

#import "ViewController.h"
#import "cellMainTable.h"

@interface ViewController ()

@property NSMutableArray *userNames;
@property NSMutableArray *userAges;
@property NSMutableArray *userImages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initController {
    self.userNames = [[NSMutableArray alloc] initWithObjects: @"Arya Stark", @"Cersei Lannister", @"Daenerys Targaryen", @"Jon Snow", @"Sansa Stark", nil];
    
    self.userImages = [[NSMutableArray alloc] initWithObjects: @"arya.jpg", @"cersei.jpg", @"daenerys.jpg", @"jon-snow.jpg", @"sansa.jpg", nil];
    
    self.userAges = [[NSMutableArray alloc] initWithObjects: @"16", @"42", @"30", @"31", @"20", nil];
}

#pragma mark - Table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userNames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    cellMainTable *cell = (cellMainTable *)[tableView dequeueReusableCellWithIdentifier: @"cellMainTable"];
    
    if(cell == nil)
    {
        [tableView registerNib:[UINib nibWithNibName: @"cellMainTable" bundle:nil] forCellReuseIdentifier: @"cellMainTable"];
        cell = (cellMainTable *)[tableView dequeueReusableCellWithIdentifier: @"cellMainTable"];
    }
    
    cell.lblName.text = [self.userNames objectAtIndex:indexPath.row];
    cell.lblAge.text = [self.userAges objectAtIndex:indexPath.row];
    cell.imgUser.image = [UIImage imageNamed:self.userImages[indexPath.row]];
    
    return cell;
    
}

#pragma mark - Action methods

- (IBAction)agregarPressed:(id)sender {
    [self.userNames addObject:@"Sergio"];
    [self.userAges addObject:@"29"];
    [self.userImages addObject:@"jon-snow.jpg"];
    [self.tblMain reloadData];
}
@end

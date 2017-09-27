//
//  InfoViewController.m
//  Mi primera tabla
//
//  Created by MacL on 27/09/17.
//  Copyright © 2017 MacL. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property NSString *nameValue;
@property NSString *ageValue;
@property NSString *descriptionValue;
@property UIImage *imageValue;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nameLabel setText:self.nameValue];
    [self.ageLabel setText:self.ageValue];
    [self.descriptionLabel setText:self.descriptionValue];
    [self.image setImage:self.imageValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInfoWithName:(NSString*)name withAge:(NSString*)age withDescription:(NSString*)description andImage:(UIImage*) image {
    
    self.nameValue = name;
    self.ageValue = age;
    self.imageValue = image;
    self.descriptionValue = description;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

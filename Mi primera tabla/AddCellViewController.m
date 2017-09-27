//
//  AddCellViewController.m
//  Mi primera tabla
//
//  Created by MacL on 26/09/17.
//  Copyright © 2017 MacL. All rights reserved.
//

#import "AddCellViewController.h"

@interface AddCellViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (nonatomic) NSMutableArray *capturedImages;
@property BOOL isEditor;

@end

@implementation AddCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.capturedImages = [[NSMutableArray alloc] init];
    _isEditor = NO;
    self.descriptionTextField.text = @"";
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_isEditor && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _isEditor = YES;
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No hay camara"
                                                                       message:@"La aplicacion esta corriendo en el simulador"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
      
        // There is not a camera on this device, so don't show the camera button.
        
        [_cameraBtn setHidden:_isEditor];
        
        /*UIToolbar *toolbar = self.navigationController.toolbar;
        NSMutableArray *toolbarItems = [toolbar.items mutableCopy];
        if (toolbarItems.count > 2)
        {
            [toolbarItems removeObjectAtIndex:2];
            [self setToolbarItems:toolbarItems animated:NO];
        }*/
    }
    else
        _isEditor = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)showImagePickerForPhotoPicker:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)showImagePickerForCamera:(id)sender {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied)
    {
        // Denies access to camera, alert the user.
        // The user has previously denied access. Remind the user that we need camera access to be useful.
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"Unable to access the Camera"
                                            message:@"To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app."
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
        // The user has not yet been presented with the option to grant access to the camera hardware.
        // Ask for it.
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^( BOOL granted ) {
            // If access was denied, we do not set the setup error message since access was just denied.
            if (granted)
            {
                // Allowed access to camera, go ahead and present the UIImagePickerController.
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:picker animated:YES completion:NULL];
            }
        }];
    else
    {
        // Allowed access to camera, go ahead and present the UIImagePickerController.
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }

}

- (IBAction)addCellBtn:(id)sender {
    
    NSString *name = self.nameTextField.text;
    NSString *age =  [NSString stringWithFormat:@"%@ años", self.ageTextField.text];
    NSString *description = self.descriptionTextField.text;
    UIImage *image = [self.imageView image];
    
    if(![name isEqual:@""] && ![age isEqual:@""] && image != nil) {
        [self.home addCellWithName:name withAge:age withDescription:description andImage:image];
    }
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn: (UITextView *) textField{

    
    [textField resignFirstResponder];
    return YES;
}


@end

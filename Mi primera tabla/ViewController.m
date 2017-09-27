//
//  ViewController.m
//  Mi primera tabla
//
//  Created by VirtualBox on 9/20/17. 
//  Copyright © 2017 VirtualBox. All rights reserved. 
//

#import "ViewController.h"
#import "cellMainTable.h"
#import "AddCellViewController.h"
#import "InfoViewController.h"

@interface ViewController ()
@property NSMutableArray *userNames;
@property NSMutableArray *userAges;
@property NSMutableArray *userImages;
@property NSMutableArray *userImagesType;
@property NSMutableArray *userDescriptions;

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

- (void) initController{
    self.userNames = [[NSMutableArray alloc] initWithObjects: @"Arya Stark", @"Cersei Lannister", @"Daenerys Targaryen", @"Jon Snow", @"Sansa Stark", nil]; 
    self.userImages = [[NSMutableArray alloc] initWithObjects: @"arya.jpg", @"cersei.jpg", @"daenerys.jpg", @"jon-snow.jpg", @"sansa.jpg", nil];
    self.userAges = [[NSMutableArray alloc] initWithObjects: @"16", @"42", @"30", @"31", @"20", nil]; 
    self.userImagesType =[[NSMutableArray alloc] initWithObjects: [NSNumber numberWithBool:false], [NSNumber numberWithBool:false], [NSNumber numberWithBool:false], [NSNumber numberWithBool:false], [NSNumber numberWithBool:false], nil ];
    
    self.userDescriptions = [[NSMutableArray alloc] initWithObjects:
                             @"Arya Stark es la segunda hija de Lord Eddard Stark y Lady Catelyn Tully. Tiene una hermana, Sansa; tres hermanos, Robb, Brandon y Rickon, y un medio-hermano bastardo, Jon Nieve, al que aprecia mucho. Como algunos de sus hermanos, ella es una cambiapieles, pudiendo entrar en la piel de su loba huargo, Nymeria.",
                             @"La reina Cersei Lannister es la hija mayor de Lord Tywin Lannister y Lady Joanna Lannister. Tiene dos hermanos, su mellizo Jaime y su hermano menor Tyrion. Tras la Guerra del Usurpador se casó con el nuevo rey, Robert Baratheon, y se convirtió en Reina de los Siete Reinos. Es madre de tres hijos, Joffrey, Myrcella y Tommen, todos fruto de su secreta relación incestuosa con su hermano Jaime.",
                             @"La reina Daenerys Targaryen, también llamada Daenerys de la Tormenta, La que no Arde, Rompedora de Cadenas, Madre de Dragones y, de manera más informal, Dany, es la hija menor del rey Aerys II Targaryen y su hermana esposa, la reina Rhaella. Luego de la Guerra del Usurpador, durante la que murieron sus padres y su hermano mayor Rhaegar, ella y su hermano Viserys vivieron en el exilio en varias Ciudades Libres. ",
                             @"Lord Jon Nieve es el Lord Comandante de la Guardia de la Noche nº 998. Es hijo bastardo de Lord Eddard Stark. Su lobo huargo, Fantasma, es albino y mudo. El emblema personal de Jon consiste en los colores de la Casa Stark invertidos, un lobo huargo de plata corriendo sobre fondo de cenizo.",
                             @"Sansa Stark es la hija mayor de Lord Eddard Stark y Lady Catelyn Tully. Tiene tres hermanos, Robb, Brandon y Rickon; una hermana, Arya, y un medio hermano bastardo, Jon Nieve. Está casada con Tyrion Lannister.", nil];
}

//////TABLE

- (NSInteger)numberOfSectionTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userNames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  

    cellMainTable *cell = (cellMainTable *)[tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"cellMainTable" bundle:nil] forCellReuseIdentifier:@"cellMainTable"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    }

    //Fill cell with info from arrays
    cell.lblName.text       = self.userNames[indexPath.row];
    cell.lblAge.text        = self.userAges[indexPath.row];
    BOOL isImage = [self.userImagesType[indexPath.row] boolValue];
    if(isImage){
        cell.imgUser.image      = self.userImages[indexPath.row];
    } else {
        cell.imgUser.image      = [UIImage imageNamed:self.userImages[indexPath.row]];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"HomeToInfo" sender:self];
}


/////END TABLE

-(void) addCellWithName:(NSString*)name withAge:(NSString*)age withDescription:(NSString *)description andImage:(UIImage *)image {
    [self.userNames addObject:name];
    [self.userAges addObject:age];
    [self.userImages addObject:image];
    [self.userImagesType addObject:[NSNumber numberWithBool:true]];
    [self.userDescriptions addObject:description];
    [self.tableMain reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier  isEqualToString:@"HomeToAdd"])
    {
        AddCellViewController *addCell = [segue destinationViewController];
    
        addCell.home = self;
    }
    else {
        InfoViewController *infoView = [segue destinationViewController];
        
        long index = [self.tableMain.indexPathForSelectedRow row];
        UIImage* image = nil;
        BOOL isImage = [self.userImagesType[index] boolValue];
        if(isImage){
            image = self.userImages[index];
        } else {
            image = [UIImage imageNamed:self.userImages[index]];
        }
        
        [infoView setInfoWithName:self.userNames[index] withAge:self.userAges[index] withDescription:self.userDescriptions[index] andImage:image];
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

@end

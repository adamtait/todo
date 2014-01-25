//
//  TodoViewController.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoViewController.h"
#import "StaticCell.h"
#import "EditableCell.h"


static NSString * const staticCellIdentifier = @"StaticCell";
static NSString * const editableCellIdentifier = @"EditableCell";

@interface TodoViewController ()

    @property (nonatomic, strong) EditableCell *specialAddingCell;
    @property (nonatomic, strong) NSMutableArray *todoDescriptions;

    - (void)handleSingleTap:(UITapGestureRecognizer *)recognizer;

@end



@implementation TodoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _specialAddingCell = NULL;
        
        _todoDescriptions = [[NSMutableArray alloc] init];
        [_todoDescriptions addObject:@"kiss Tam"];
        [_todoDescriptions addObject:@"tell Tam how much you love her"];
        [_todoDescriptions addObject:@"always listen carefully to Tam"];
        [_todoDescriptions addObject:@"understand the emotional context of what Tam says"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[self tableView] registerClass:[StaticCell class] forCellReuseIdentifier:staticCellIdentifier];
    [[self tableView] registerClass:[EditableCell class] forCellReuseIdentifier:editableCellIdentifier];
    
    self.navigationItem.title = @"Adam's Todo List";
    
    // right + navigation button
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(rightNavButtonTouched:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    
    // handle touch events
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    [self.navigationController.view addGestureRecognizer:singleFingerTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_specialAddingCell != NULL) {
        return [_todoDescriptions count] + 1;
    } else {
        return [_todoDescriptions count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"special editing cell is / %@ /", _specialAddingCell);
    if (_specialAddingCell != NULL && indexPath.row == 0)
    {
        NSLog(@"returning editing cell");
        [_specialAddingCell cellWillShow];
        return _specialAddingCell;
    }
    else
    {
        NSLog(@"returning static cell");
        StaticCell *staticCell = [tableView dequeueReusableCellWithIdentifier:staticCellIdentifier forIndexPath:indexPath];
        if (staticCell)
        {
            [staticCell updateContentWithString:_todoDescriptions[indexPath.row]];
        }
        return staticCell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


#pragma events

- (IBAction)rightNavButtonTouched:(id)sender
{
    if (_specialAddingCell == NULL) {
        _specialAddingCell = [[EditableCell alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}



- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    NSLog(@"got single tap");
    
    if (_specialAddingCell != NULL) {
        [_specialAddingCell setEditing:NO animated:YES];
        [_specialAddingCell endEditing:YES];
        _specialAddingCell = NULL;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}


@end

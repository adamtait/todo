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

    - (StaticCell *)createOrLoadStaticCellFromIndexPath:(NSIndexPath *)indexPath;

    @property (nonatomic, strong) UITapGestureRecognizer *singleFingerTap;
    - (void)doneAdding:(UITapGestureRecognizer *)recognizer;

@end



@implementation TodoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _specialAddingCell = NULL;
        _singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneAdding:)];
        
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
    
    [self.tableView setDelegate:self];
    
    [[self tableView] registerClass:[StaticCell class] forCellReuseIdentifier:staticCellIdentifier];
    [[self tableView] registerClass:[EditableCell class] forCellReuseIdentifier:editableCellIdentifier];
    
    self.navigationItem.title = @"Adam's Todo List";
    
    // right '+' navigation button
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightNavButtonTouched:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    // left 'edit' navigation button
    [self.navigationItem setLeftBarButtonItem:self.editButtonItem];
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

- (StaticCell *)createOrLoadStaticCellFromIndexPath:(NSIndexPath *)indexPath
{
    StaticCell *staticCell = [self.tableView dequeueReusableCellWithIdentifier:staticCellIdentifier forIndexPath:indexPath];
    if (staticCell)
    {
        [staticCell updateContentWithString:_todoDescriptions[indexPath.row]];
    }
    return staticCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"special editing cell is / %@ /", _specialAddingCell);
    if (_specialAddingCell != NULL && indexPath.row == 0)
    {
        NSLog(@"returning editing cell");
        [_specialAddingCell cellWillShow];
        
        // handle touch events
        [self.view addGestureRecognizer:_singleFingerTap];
        [self.navigationController.view addGestureRecognizer:_singleFingerTap];
        
        return _specialAddingCell;
    }
    else
    {
        NSLog(@"returning static cell");
        return [self.tableView dequeueReusableCellWithIdentifier:staticCellIdentifier forIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_todoDescriptions removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    // change order of item in NSMutableArray self.todoDescriptions
    NSString *item = [_todoDescriptions objectAtIndex:fromIndexPath.row];
    [_todoDescriptions removeObjectAtIndex:fromIndexPath.row];
    [_todoDescriptions insertObject:item atIndex:toIndexPath.row];
    
    NSLog(@"moved todo from / %d / to / %d /", fromIndexPath.row, toIndexPath.row);
    
}



#pragma UITableViewDelegate


- (void)tableView:(UITableView *)tableView
willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell class] == [StaticCell class])
    {
        [(StaticCell *)cell updateContentWithString:_todoDescriptions[indexPath.row]];
    }
}


- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"checking estimated height");
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize theSize = [_todoDescriptions[indexPath.row] sizeWithFont:[StaticCell defaultFont]
                                                  constrainedToSize:CGSizeMake(300.0f, 9999.0f)
                                                      lineBreakMode:[StaticCell defaultLineBreakMode]];
    return theSize.height + 33; // 33 just seems to be the magic height for centering the text in the UITableViewCell
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell / %d / did get deselected", indexPath.row);
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell / %d / did finish editing", indexPath.row);
    StaticCell *cell = [self.tableView dequeueReusableCellWithIdentifier:staticCellIdentifier forIndexPath:indexPath];
    [cell resignFirstResponder];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


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
    } else {
        [self doneAdding:NULL];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    NSLog(@"TableViewController got a setEditing / %hhd / with animation / %hhd /", editing, animated);
    [super setEditing:editing animated:animated];
}


- (void)doneAdding:(UITapGestureRecognizer *)recognizer {
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    NSLog(@"got single tap");
    
    if (_specialAddingCell != NULL) {
        
        [self.view removeGestureRecognizer:_singleFingerTap];
        [self.navigationController.view removeGestureRecognizer:_singleFingerTap];
        
        // store the new description of the added todo item
        NSString *newDescription = [_specialAddingCell getText];
        
        // stop editing and delete the _specialAddngCell
        [_specialAddingCell setEditing:NO animated:YES];
        [_specialAddingCell endEditing:YES];
        _specialAddingCell = NULL;
        
        // tell the UITableViewController to remove the specialEditingCell
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        // tell the UITableViewController to add the new cell
        [_todoDescriptions insertObject:newDescription atIndex:indexPath.row];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}


@end

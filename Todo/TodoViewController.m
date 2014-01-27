//
//  TodoViewController.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoViewController.h"
#import "TodoListCell.h"
#import "CellTextView.h"
#import "TodoList.h"



static NSString * const cellIdentifier = @"TodoListCell";

@interface TodoViewController ()

    // private properties
    @property (nonatomic, strong) TodoList *todoList;
    @property BOOL editingMode;

    // events
    - (IBAction)rightNavButtonTouched:(id)sender;

    @property (nonatomic, strong) UITapGestureRecognizer *singleFingerTap;
    - (void)gotTapGesture:(UITapGestureRecognizer *)recognizer;

    // editing
    - (void)startEditing;
    - (void)stopEditing;

@end



@implementation TodoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _editingMode = NO;
        _todoList = [[TodoList alloc] init];
        _singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotTapGesture:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // setup the UITableView delegate to be this UITableViewController
    [self.tableView setDelegate:self];
    
    // register the TodoListCell class for the reuseIdentifier
    [[self tableView] registerClass:[TodoListCell class] forCellReuseIdentifier:cellIdentifier];
    
    // add a title to the navigation bar
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
    if (_editingMode) {
        return [_todoList count] + 1;
    } else {
        return [_todoList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UITableViewController: returning cell for index / %d /", indexPath.row);
    return [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
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
        [_todoList deleteFromIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [_todoList moveStringFromIndex:fromIndexPath.row toIndex:toIndexPath.row];
    
    
}



#pragma UITableViewDelegate


- (void)tableView:(UITableView *)tableView
willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content;
    if (_editingMode && indexPath.row > 0) {
        content = [_todoList getStringForIndex:(indexPath.row - 1)];
    } else if (!_editingMode) {
        content = [_todoList getStringForIndex:indexPath.row];
    }
    
    if (content) {
        NSLog(@"UITableViewController will show cell with content / %@ /", content);
        [(TodoListCell *)cell updateContentWithString:content];
    } else {
        [(TodoListCell *)cell becomeFirstResponder];
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
    NSLog(@"UITableViewController: checking estimated height");
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content;
    if (_editingMode && indexPath.row == 0) {
        content = @"a todo list item";
    } else if (_editingMode) {
        // need to subtract 1 because the content for the first cell in editingMode is empty (that's the editing cell)
        content = [_todoList getStringForIndex:(indexPath.row - 1)];
    } else {
        content = [_todoList getStringForIndex:indexPath.row];
    }
    CGSize calculatedSize = [content sizeWithFont:[CellTextView defaultFont]
                                        constrainedToSize:CGSizeMake(300.0f, 9999.0f)
                                            lineBreakMode:[CellTextView defaultLineBreakMode]];
    
    NSLog(@"UITableViewController: heightForRowAtIndexPath will be / %0.2f / for cell # /%d /", calculatedSize.height + 33, indexPath.row);
    return calculatedSize.height + 33; // 33 just seems to be the magic height for centering the text in the UITableViewCell
}

- (void)tableView:(UITableView *)tableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UITableViewController: cell / %d / did get deselected", indexPath.row);
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView
didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UITableViewController: cell / %d / did finish editing", indexPath.row);
    TodoListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
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


#pragma UIResponder methods

- (void)gotTapGesture:(UITapGestureRecognizer *)recognizer {
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    NSLog(@"got single tap");
    if (_editingMode) {
        [self stopEditing];
    }
}


#pragma events

- (IBAction)rightNavButtonTouched:(id)sender
{
    if (!_editingMode) {
        [self startEditing];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    NSLog(@"TableViewController got a setEditing / %hhd / with animation / %hhd /", editing, animated);
    [super setEditing:editing animated:animated];
}

- (void)gotTextViewDidEndEditingEvent:(id)sender
{
    NSLog(@"TodoViewController gotTextViewDidEndEditingEvent");
    if (_editingMode) {
        [self stopEditing];
    }
}


#pragma editing

- (void)startEditing
{
    if (!_editingMode) {
        _editingMode = YES;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        // add observer for textViewDidEndEditing event
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotTextViewDidEndEditingEvent:) name:@"textViewDidEndEditing" object:nil];
        [self.view addGestureRecognizer:_singleFingerTap];
        [self.navigationController.view addGestureRecognizer:_singleFingerTap];
    }
}

- (void)stopEditing
{
    if (_editingMode) {
        _editingMode = NO;
        
        // remove observers and events
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.view removeGestureRecognizer:_singleFingerTap];
        [self.navigationController.view removeGestureRecognizer:_singleFingerTap];
        
        // store the new description of the added todo item
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        TodoListCell *cell = (TodoListCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        NSString *newDescription = [cell getText];
        
        // tell the UITableViewController to remove the editing cell
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        // tell the UITableViewController to add the new cell
        [_todoList addString:newDescription];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}


@end

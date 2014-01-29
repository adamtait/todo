//
//  TodoViewController.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoViewController.h"
#import "TodoCell.h"
#import "CellTextView.h"
#import "TodoList.h"


static NSString * const cellIdentifier = @"TodoCell";

@interface TodoViewController ()

    // private properties
    @property (nonatomic, strong) TodoList *todoList;
    @property BOOL editingMode;

    // events
    - (IBAction)rightNavButtonTouched:(id)sender;

    @property (nonatomic, strong) UITapGestureRecognizer *singleFingerTap;
    - (void)gotTapGesture:(UITapGestureRecognizer *)recognizer;

    - (void)gotTodoCellDidChangeEvent:(id)sender;
    - (void)gotTodoCellDidBeginEditingEvent:(id)sender;
    - (void)gotTodoCellDidEndEditingEvent:(id)sender;

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
    
    // register the TodoCell class for the reuseIdentifier
    [[self tableView] registerClass:[TodoCell class] forCellReuseIdentifier:cellIdentifier];
    
    // setup navigation bar
    self.navigationItem.title = @"to.do";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightNavButtonTouched:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [self.navigationItem setLeftBarButtonItem:self.editButtonItem];
    
    // start listening for textViewDidChange events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotTodoCellDidBeginEditingEvent:) name:@"todoCellDidBeginEditing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotTodoCellDidChangeEvent:) name:@"todoCellDidChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotTodoCellDidEndEditingEvent:) name:@"todoCellDidEndEditing" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_todoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell.todoListItem) {
        cell.todoListItem = [_todoList getPFObjectForIndex:indexPath.row];
    }
    
    return cell;
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
        [_todoList deleteFromIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    [(TodoCell *)cell updateContentWithString:[_todoList getStringForIndex:indexPath.row]];

    if (_editingMode && indexPath.row == 0) {
        [(TodoCell *)cell becomeFirstResponder];
    }
}


- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellTextView *fakeTextView = [[CellTextView alloc] initWithFrame:[TodoCell defaultFrame]];
    [fakeTextView updateContentWithString:[_todoList getStringForIndex:indexPath.row]];    // setAttributedText:[[NSAttributedString alloc] initWithString:[_todoList getStringForIndex:indexPath.row]]

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = [CellTextView defaultLineBreakMode];
    CGRect textRect = [[fakeTextView getTextView].text boundingRectWithSize:CGSizeMake([TodoCell defaultFrame].size.width, MAXFLOAT)
                                            options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                               attributes:@{NSFontAttributeName:[CellTextView defaultFont],
                                                            NSParagraphStyleAttributeName:paragraphStyle}
                                                  context:nil];
    return textRect.size.height + 22;
}

- (void)tableView:(UITableView *)tableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView
didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath] resignFirstResponder];
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
    [super setEditing:editing animated:animated];
}

- (void)gotTodoCellDidChangeEvent:(id)sender
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
}

- (void)gotTodoCellDidBeginEditingEvent:(id)sender
{
    NSNotification *notification = (NSNotification *)sender;
    TodoCell *cell = notification.object;
    [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}


- (void)gotTodoCellDidEndEditingEvent:(id)sender
{
    NSNotification *notification = (NSNotification *)sender;
    TodoCell *cell = notification.object;
    NSString *index = [cell.todoListItem objectForKey:@"index"];
    [_todoList updateString:[cell getText] atIndex:index.intValue];
    
    if (_editingMode) {
        [self stopEditing];
    }
}


#pragma editing

- (void)startEditing
{
    if (!_editingMode) {
        _editingMode = YES;
        
        [_todoList addString:@""];
        
        // add observer for textViewDidEndEditing event
        [self.view addGestureRecognizer:_singleFingerTap];
        [self.navigationController.view addGestureRecognizer:_singleFingerTap];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (void)stopEditing
{
    if (_editingMode) {
        _editingMode = NO;
        
        // remove observers and events
        [self.view removeGestureRecognizer:_singleFingerTap];
        [self.navigationController.view removeGestureRecognizer:_singleFingerTap];
        
        // end the cell's editing and ownership over the keyboard
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        TodoCell *cell = (TodoCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell resignFirstResponder];
    }
}


@end

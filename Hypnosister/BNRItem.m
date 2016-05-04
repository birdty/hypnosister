//
//  BNRItem.m
//  Quiz
//
//  Created by Tyler Bird on 2/17/16.
//  Copyright (c) 2016 Big Nerd Ranch. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

-(void)setContainedItem:(BNRItem *)item
{
    _containedItem = item;
    self.containedItem.container = self;
}


-(instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self = [super init];
    
    if ( self )
    {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
    }
    
    return self;
}

-(instancetype)initWithItemname:(NSString *)name
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@"0"];
}

-(instancetype)init
{
    return [self initWithItemname:@"Item"];
}

+(instancetype)randomItem
{
    NSArray * randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    NSArray * randomNountList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    
    NSInteger nounIndex = arc4random() % [randomNountList count];
    
    NSString * randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNountList[nounIndex] ];
    
    int randomValue = arc4random() % 100;
    
    NSString * randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", '0' + arc4random() % 10, 'A' + arc4random() % 26, '0' + arc4random() % 10, 'A' + arc4random() % 26, '0' + arc4random() % 10];
    
    
    BNRItem * newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}



@end

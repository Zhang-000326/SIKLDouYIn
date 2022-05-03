//
//  SILKMacros.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import "SILKMacros.h"

BOOL SILK_isEmptyString(id param){
    if(!param){
        return YES;
    }
    if ([param isKindOfClass:[NSString class]]){
        NSString *str = param;
        return (str.length == 0);
    }
    return YES;
}

BOOL SILK_isEmptyArray(id param){
    if(!param){
        return YES;
    }
    if ([param isKindOfClass:[NSArray class]]){
        NSArray *array = param;
        return (array.count == 0);
    }
    return YES;
}

BOOL SILK_isEmptyDictionary(id param){
    if(!param){
        return YES;
    }
    if ([param isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = param;
        return (dict.count == 0);
    }
    return YES;
}

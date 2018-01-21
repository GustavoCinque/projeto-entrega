//
//  CategoriaDao.m
//  ProjetoSecreto
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import "CategoriaDao.h"
#import "AppDelegate.h"

@implementation CategoriaDao

- (DBCategoria *) newInstance {
    DBCategoria *c = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([DBCategoria class]) inManagedObjectContext:[CategoriaDao context]];
    return c;
}

+ (NSManagedObjectContext*)context{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}

- (BOOL) salvar{
    NSManagedObjectContext *context = [CategoriaDao context];
    NSError *error;
    return [context save:&error];
}

- (void) remover:(DBCategoria*) categoria {
    NSManagedObjectContext *context = [CategoriaDao context];
    [context deleteObject:categoria];
    [context save:nil];
}

- (NSArray<DBCategoria*>*) pesquisarTodos {
    NSFetchRequest *request = [DBCategoria fetchRequest];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"idCategoria" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    NSError *error;
    NSArray *array = [[CategoriaDao context] executeFetchRequest:request error:&error];
    return array;
}

- (void) removerTodos {
    for (DBCategoria *categoria in self.pesquisarTodos) {
        [self remover:categoria];
    }
}

@end

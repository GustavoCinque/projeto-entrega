//
//  EntradaDao.m
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 16/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import "EntradaDao.h"
#import "AppDelegate.h"

@implementation EntradaDao

- (DBEntrada *) newInstance {
    DBEntrada *c = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([DBEntrada class]) inManagedObjectContext:[EntradaDao context]];
    return c;
}

+ (NSManagedObjectContext*)context{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}

- (BOOL) salvar {
    NSManagedObjectContext *context = [EntradaDao context];
    NSError *error;
    return [context save:&error];
}

- (void) remover:(DBEntrada*) categoria {
    NSManagedObjectContext *context = [EntradaDao context];
    [context deleteObject:categoria];
    [context save:nil];
}

- (NSArray<DBEntrada*>*) pesquisarTodos:(int) usuario{
    NSFetchRequest *request = [DBEntrada fetchRequest];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"idEntrada" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"usuario == %d", usuario];
    [request setPredicate:predicate];
    [request setSortDescriptors:sortDescriptors];
    NSError *error;
    NSArray *array = [[EntradaDao context] executeFetchRequest:request error:&error];
    return array;
}

- (NSArray<DBEntrada*>*) pesquisarTodosSemUsuario{
    NSFetchRequest *request = [DBEntrada fetchRequest];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"idEntrada" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    NSError *error;
    NSArray *array = [[EntradaDao context] executeFetchRequest:request error:&error];
    return array;
}

- (void) removerTodos {
    for (DBEntrada *entrada in self.pesquisarTodosSemUsuario) {
        [self remover:entrada];
    }
}

@end

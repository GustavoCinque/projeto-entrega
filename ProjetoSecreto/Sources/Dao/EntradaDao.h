//
//  EntradaDao.h
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 16/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBEntrada+CoreDataClass.h"

@interface EntradaDao : NSObject

- (DBEntrada*) newInstance;
- (BOOL) salvar;
- (void) remover:(DBEntrada*) entrada;
- (NSArray<DBEntrada*>*) pesquisarTodos:(int)usuario;
- (NSArray<DBEntrada*>*) pesquisarTodosSemUsuario;
- (void) removerTodos;

@end

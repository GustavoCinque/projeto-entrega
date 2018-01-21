//
//  CategoriaDao.h
//  ProjetoSecreto
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBCategoria+CoreDataClass.h"

@interface CategoriaDao : NSObject

- (DBCategoria*) newInstance;
- (BOOL) salvar;
- (void) remover:(DBCategoria*) categoria;
- (NSArray<DBCategoria*>*) pesquisarTodos;
- (void) removerTodos;

@end

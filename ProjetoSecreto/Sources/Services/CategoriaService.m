#import "CategoriaService.h"

@implementation CategoriaService

- (void) carregarPrimeiraCargaCategorias:(void (^)(NSArray<Categoria *> *, NSError *)) metodoParaRetorno{
    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/m8jnt"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error) {
            NSError *jsonError = nil;
            RootCategoria *categorias = [[RootCategoria alloc] initWithData:data error:&jsonError];
            
            if(!jsonError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    metodoParaRetorno(categorias.categorias.categoria, nil);
                });
            } else {
                NSLog(@"Erro ao converter json: %@", jsonError	);
            }
            
        } else {
            NSLog(@"Erro ao ler json: %@", error);
        }
        
    }] resume];
}

- (void) carregarSegundaCargaCategorias:(void (^)(NSArray<Categoria *> *, NSError *)) metodoParaRetorno{
    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/15af0p"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error) {
            NSError *jsonError = nil;
            RootCategoria *categorias = [[RootCategoria alloc] initWithData:data error:&jsonError];
                        
            if(!jsonError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    metodoParaRetorno(categorias.categorias.categoria, nil);
                });
            } else {
                NSLog(@"Erro ao converter json: %@", jsonError	);
            }
            
        } else {
            NSLog(@"Erro ao ler json: %@", error);
        }

        
    }] resume];
}



@end

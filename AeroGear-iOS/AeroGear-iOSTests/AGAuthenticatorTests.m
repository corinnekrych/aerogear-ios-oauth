/*
 * JBoss, Home of Professional Open Source.
 * Copyright 2012 Red Hat, Inc., and individual contributors
 * as indicated by the @author tags.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <SenTestingKit/SenTestingKit.h>
#import "AGAuthenticator.h"

@interface AGAuthenticatorTests : SenTestCase

@end

@implementation AGAuthenticatorTests {
    AGAuthenticator* _authenticator;
}

-(void)setUp {
    [super setUp];
    
    // create Authenticator
    _authenticator = [AGAuthenticator authenticator];
}

-(void)tearDown {
    [super tearDown];
    
    _authenticator = nil;
}

-(void) testAuthenticatorCreation {
    STAssertNotNil(_authenticator, @"authenticator should not be nil");
}

-(void) testAddModule {
    id<AGAuthenticationModule> module = [_authenticator auth:^(id<AGAuthConfig> config) {
        [config name:@"SomeModule"];
        [config baseURL:[NSURL URLWithString:@"https://server:8080/application/"]];
    }];
    STAssertNotNil(module, @"module should not be nil");
    
    // check "default" endpoint URLs:
    STAssertEqualObjects(@"https://server:8080/application/auth/login",
                         [module loginEndpoint],
                         @"has expected login endpoint URL");
    STAssertEqualObjects(@"https://server:8080/application/auth/logout",
                         [module logoutEndpoint],
                         @"has expected logout endpoint URL");
    STAssertEqualObjects(@"https://server:8080/application/auth/enroll",
                         [module enrollEndpoint],
                         @"has expected enroll endpoint URL");
}

-(void) testAddModuleWithDifferentEndpoints {
    id<AGAuthenticationModule> module =  [_authenticator auth:^(id<AGAuthConfig> config) {
        [config name:@"SomeModule"];
        [config baseURL:[NSURL URLWithString:@"https://server:8080/application/subcontext/"]];
        [config loginEndpoint:@"auth/in"];
        [config logoutEndpoint:@"auth/out"];
        [config enrollEndpoint:@"auth/register"];
    }];
    
    STAssertNotNil(module, @"module should not be nil");
    
    // check endpoint URLs:
    STAssertEqualObjects(@"https://server:8080/application/subcontext/auth/in",
                         [module loginEndpoint],
                         @"has expected login endpoint URL");
    STAssertEqualObjects(@"https://server:8080/application/subcontext/auth/out",
                         [module logoutEndpoint],
                         @"has expected logout endpoint URL");
    STAssertEqualObjects(@"https://server:8080/application/subcontext/auth/register",
                         [module enrollEndpoint],
                         @"has expected enroll endpoint URL");
}

-(void) testAddModuleWithDefaultType {
    id<AGAuthenticationModule> module = [_authenticator auth:^(id<AGAuthConfig> config) {
        [config name:@"SomeModule"];
        [config baseURL:[NSURL URLWithString:@"https://server:8080/application/"]];
    }];
    STAssertNotNil(module, @"module should not be nil");
    
    //check default type
    STAssertEqualObjects(@"REST", module.type, @"has expected REST type");
}

-(void) testAddModuleWithInvalidType {
    id<AGAuthenticationModule> module = [_authenticator auth:^(id<AGAuthConfig> config) {
        [config name:@"SomeModule"];
        [config baseURL:[NSURL URLWithString:@"https://server:8080/application/"]];
        [config type:@"INVALID"];
    }];
    
    STAssertNil(module, @"module should be nil");
}

-(void) testAddModules {
    id<AGAuthenticationModule> module = [_authenticator auth:^(id<AGAuthConfig> config) {
        [config name:@"SomeModule"];
        [config baseURL:[NSURL URLWithString:@"https://server:8080/application/"]];
    }];

    STAssertNotNil(module, @"module should not be nil");
    
    id<AGAuthenticationModule> otherModule = [_authenticator auth:^(id<AGAuthConfig> config) {
        [config name:@"OtherModule"];
        [config baseURL:[NSURL URLWithString:@"https://server:8080/another-application/"]];
    }];
   
    STAssertNotNil(otherModule, @"other module should not be nil");
    
    // look em up:
    STAssertNotNil([_authenticator get:@"SomeModule"], @"module should not be nil");
    STAssertNotNil([_authenticator get:@"OtherModule"], @"module should not be nil");
}

-(void) testAddAndRemoveModule {
    id<AGAuthenticationModule> module = [_authenticator auth:^(id<AGAuthConfig> config) {
        [config name:@"SomeModule"];
        [config baseURL:[NSURL URLWithString:@"https://server:8080/application/"]];
    }];
    
    STAssertNotNil(module, @"module should not be nil");
    // look it up:
    STAssertNotNil([_authenticator get:@"SomeModule"], @"module should not be nil");
 
    // remove it
    [_authenticator remove:@"SomeModule"];
    // look it up:
    STAssertNil([_authenticator get:@"SomeModule"], @"module was already removed");
}

-(void) testRemoveNonExistingModule {
    id<AGAuthenticationModule> module = [_authenticator auth:^(id<AGAuthConfig> config) {
        [config name:@"SomeModule"];
        [config baseURL:[NSURL URLWithString:@"https://server:8080/application/"]];
    }];
    
    STAssertNotNil(module, @"module should not be nil");

    // remove non existant
    id<AGAuthenticationModule> fooModule = [_authenticator remove:@"FOO"];
    STAssertNil(fooModule, @"module should be nil");
}

@end

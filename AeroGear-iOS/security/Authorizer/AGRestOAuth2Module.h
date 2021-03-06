/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
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

#import <Foundation/Foundation.h>
#import "AGAuthzConfig.h"
#import "AGOAuth2AuthzModuleAdapter.h"
#import "AGHttpClient.h"

/**
 An internal AGAuthorization module implementation that uses REST as the authz transport.
 
 *IMPORTANT:* Users are not required to instantiate this class directly, instead an instance of this class is returned
 automatically when an Authorizer with default configuration is constructed or with the _type_ config option set to
 _"REST"_. See AGAuthorizer and AGAuthzModule class documentation for more information.
 
 */
@interface AGRestOAuth2Module : NSObject <AGOAuth2AuthzModuleAdapter> {
    AGHttpClient* _restClient;
}

-(instancetype) initWithConfig:(id<AGAuthzConfig>) authzConfig;
+(instancetype) moduleWithConfig:(id<AGAuthzConfig>) authzConfig;

// Used for injecting mock
-(instancetype) initWithConfig:(id<AGAuthzConfig>) authzConfig client:(AGHttpClient*)client;

-(void)extractCode:(NSNotification*)notification success:(void (^)(id object))success failure:(void (^)(NSError *error))failure;

// to be overriden if necessary by OAuth2 specific adapter
-(void)requestAuthorizationCodeSuccess:(void (^)(id object))success
                               failure:(void (^)(NSError *error))failure;

-(void)refreshAccessTokenSuccess:(void (^)(id object))success
                         failure:(void (^)(NSError *error))failure;

-(void)exchangeAuthorizationCodeForAccessToken:(NSString*)code
                                       success:(void (^)(id object))success
                                       failure:(void (^)(NSError *error))failure;

@end

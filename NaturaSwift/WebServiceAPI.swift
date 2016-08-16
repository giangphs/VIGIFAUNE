//
//  WebServiceAPI.swift
//  NaturaSwift
//
//  Created by Manh on 4/27/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
//**********************  WEB SERVICES  **********************************//
//ROOTURL (Base API)//////////////////////////////////////////////////////////////////////////////////////

//DEV
//#define BASE_API                                        @"https://naturapass.e-conception.fr/api"
//#define IMAGE_ROOT_API                                  @"https://naturapass.e-conception.fr"
//#define LINK_SOCKET                                      @"https://naturapass.e-conception.fr"

////PROD-TEST
//#define BASE_API                                        @"https://naturapassprod.e-conception.fr/api"
//#define IMAGE_ROOT_API                                  @"https://naturapassprod.e-conception.fr"
//#define LINK_SOCKET                                     @"https://naturapassprod.e-conception.fr"
//



class WebServiceAPI: NSObject
{
    
    //MARK: INIT

    
    override init()
    {
        super.init();
        
    }
    
    //MARK:LOGIN
    internal func  fnGET_REAL_LOGIN(email: String, password: String, pushToken: String,complete onComplete: (complete: AnyObject?, code: Int)->())
    {
        
        Alamofire.request(.GET,REAL_LOGIN(email, password: password, pushToken: pushToken)).responseJSON
            { response in
                //handle JSON
                let (resultValue,resultCode) = self.procesingRequest(response);
                
                
                
                onComplete(complete: resultValue,code: resultCode);
        }
        
    }
    
    internal func fnGET_REAL_LOGIN_NO_PUSH(email:String,password:String,complete completed: (Response<AnyObject,NSError>)->())
    {
        Alamofire.request(.GET,"https://naturapass.e-conception.fr/app_dev.php/api/user/login?email=dinhmanhvp@gmail.com&password=d2009cda4865812da8c2c0527c69ed3e287a78ed&device=ios&identifier=(null)&name=iOS&authorized=0").responseJSON
            { response in
                //handle JSON
                
                completed(response);
        }
    }
    
    internal func fnGET_FB_LOGIN_API(facebook_id:String,identifier:String,complete completed: (Response<AnyObject,NSError>)->())
    {
        Alamofire.request(.GET,FB_LOGIN_API(facebook_id, identifier: identifier)).responseJSON
            { response in
                //handle JSON
                
                completed(response);
        }
    }
    
    internal func fnPUT_FB_LOGIN_API(putDict: NSDictionary,complete completed: (Response<AnyObject,NSError>)->())
    {
        Alamofire.request(.PUT, PUTFACEBOOKUSERACTION_API(), parameters: putDict as? [String : AnyObject], encoding: .URL).responseJSON
            {
                response in
                completed(response);
                
        }
    }
    
    internal func fnPOST_FB_LOGIN_API(putDict: NSDictionary,attachment: NSDictionary, complete completed: (Response<AnyObject,NSError>)->())
    {
        let fileName: String = attachment["kFileName"] as! String;
        let fileData: NSData = attachment["kFileData"] as! NSData;
        Alamofire.upload(
            .POST,
            POSTFACEBOOKUSERACTION_API(),
            multipartFormData: { multipartFormData in
                for param in putDict
                {
                    multipartFormData.appendBodyPart(
                        data: putDict["\(param)"]!.dataUsingEncoding(NSUTF8StringEncoding)!,
                        name: "\(param)"
                    )
                }
                multipartFormData.appendBodyPart(
                    data: fileData,
                    name: "user[photo][file]",
                    fileName: fileName,
                    mimeType: "image/png"
                )
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON {
                        response in
                        completed(response);
                        
                    }
                case .Failure(let encodingError):
                    print("\(encodingError)")
                    break;
                }
            }
        )
    }
    //MARK: - MAP
    
    internal func PUT_SQLITE_ALL_POINTS_IN_MAP_WITHPARAM(param: NSDictionary,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.PUT, GET_SQLITE_ALL_POINTS_IN_MAP(), parameters: param as? [String : AnyObject], encoding: .URL).responseJSON
            {
                response in
                
                print("\(response)")
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
                
        }
        
    }
    
    //MARK: - MUR
    internal func fnGET_PUBLICATION_FILTEROFF_WITHLIMIT(limit:String,offset:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.GET,GET_PUBLICATION_FILTEROFF(limit, offset: offset)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnGET_PUBLICATION_ACTIONS(limit:String,offset:String,strShareType: String,strGroupAppend:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.GET,GETPUBLICATION(limit, offset: offset, share: strShareType, strGroupAppend: strGroupAppend)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnGET_PUBLICATION_COMMENT(publication_id:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        //mld_: handcode
        Alamofire.request(.GET,GETCOMMENT(publication_id, publication_limit: "1000", loadedCount: "0")).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnDELETE_PUBLICATION_ACTION(publication_id:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.GET,DELETEPUBLICATIONACTION_API(publication_id)).responseJSON
            { response in
                //handle JSON

                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    
    
    

    //MARK: - AGENDA
    internal func  fnGETUSERLOUNGESACTION_API(limit: String, offset: String, complete onComplete: (complete: AnyObject?, code: Int)->())
    {
        
        Alamofire.request(.GET,GETUSERLOUNGESACTION_API(limit, offset: offset)).responseJSON
            { response in
                //handle JSON
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue,code: resultCode);
        }
        
    }

    //MARK: - GROUPS
    internal func fnGET_MYGROUP_ACITON(filter: String, limit:String,offset:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.GET,GET_MY_GROUPSACTION_API(filter,limit: limit, offset: offset)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnGET_GROUP_PUBLICATION_ACITON(my_id: String, limit:String,offset:String,myKind:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        
        Alamofire.request(.GET,GET_GROUP_PUBLICATION(myKind, myid: my_id, limit: limit, offset: offset)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnGET_ITEM_WITH_KIND(my_id: String,myKind:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        
        Alamofire.request(.GET,GET_ITEM_API(myKind, myid: my_id)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnGET_GROUP_TOUTES_ACITON(filter: String, limit:String,offset:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.GET,GET_GROUP_TOUTES_API(filter,limit:limit, offset: offset)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnPUT_GROUP_USER_JOIN_ACITON(group_id: String, user_id:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.PUT,PUT_GROUP_USER_JOIN_API(group_id, user_id: user_id)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnPOST_GROUP_USER_JOIN_ACITON(group_id: String, user_id:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.POST,POST_GROUP_USER_JOIN_API(group_id, user_id: user_id)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnGET_GROUP_SUBSCRIBERFRIEND_ACITON(group_id: String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.GET,GET_GROUP_SUBSCRIBERFRIEND_API(group_id)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnPOST_USER_FRIENDSHIP_ACITON(user_id:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.POST,POST_USER_FRIENDSHIP_API(user_id)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnV2_GET_GROUP_INVITATION_ACITON(complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.GET,V2_GET_GROUP_INVITATION_API()).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnPUT_JOIN_KIND_ACITON(mykind: String, mykind_id:String, strUserID:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        
        Alamofire.request(.PUT,PUT_JOIN_KIND_API(mykind, group_id: mykind_id, user_id: strUserID)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnDELETE_JOIN_KIND_ACITON(mykind: String, mykind_id:String, strUserID:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        
        Alamofire.request(.DELETE,DELETE_JOIN_KIND_API(mykind, mykind_id: mykind_id, user_id: strUserID)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnPUT_GROUP_ACCEPT_INVITATION_ACITON(mykind: String, mykind_id:String, strUserID:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.PUT,PUT_GROUP_ACCEPT_INVITATION_API(mykind,user_id:strUserID, group_id: mykind_id)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnDELETE_GROUP_INVITATION_ACITON(mykind: String, mykind_id:String, strUserID:String,complete onComplete: (complete: AnyObject, code: Int)->())
    {
        
        Alamofire.request(.DELETE,DELETE_GROUP_INVITATION_API(mykind, mykind_id: mykind_id, user_id: strUserID)).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    internal func fnGET_ALL_HUNTS_ADMIN_ACITON(complete onComplete: (complete: AnyObject, code: Int)->())
    {
        Alamofire.request(.GET,GET_ALL_HUNTS_ADMIN()).responseJSON
            { response in
                //handle JSON
                
                let (resultValue,resultCode) = self.procesingRequest(response);
                onComplete(complete: resultValue!,code: resultCode);
        }
    }
    
    //MARK: - procesingRequest
    func procesingRequest(inputData:Response<AnyObject,NSError>)  -> (returnData: AnyObject?, code: Int) {
        

        var code: Int = 200
        
        switch inputData.result {
        case .Success(let JSON):
            let inputData = JSON as! NSDictionary
            
            
            //Code from
            //Response data include CODE
            if (inputData["code"] != nil) {
                code = (inputData["code"] as? Int)!;
            }
            
            if code ==  503 {
                return (nil,code);
            }
            else if code == 500
            {
                return (nil,code);
            }
            else if code == 404
            {
                return (nil,code);
            }
            else if code == 401
            {
                return (nil,code);
            }
            else if code == 403
            {
                return (nil,code);
            }
            else
            {
                return (inputData,code);
            }
            
        case .Failure(let error):
            //Code system error
            
            print("Fail")
            return (nil,error.code);
            
        }
        
        //        var code:Int = 200;//(inputData.result.error?.code)!;
        
        //        if jsonData.isEqual(nil) {
        //            return (nil, code);
        //        }
        //
        //        if jsonData.isKindOfClass(NSArray.classForCoder()) {
        //            return (nil, code);
        //        }
        
        //        else if jsonData.isKindOfClass(NSDictionary.classForCoder())
        //        {
        //            if (jsonData["code"] != nil) {
        //                code = (jsonData["code"] as? Int)!;
        //            }
        //            if code ==  503 {
        //                return (nil,code);
        //            }
        //            else if code == 500
        //            {
        //                return (nil,code);
        //            }
        //            else if code == 500
        //            {
        //                return (nil,code);
        //            }
        //            else
        //            {
        //                return ((jsonData as? NSDictionary)!,200);
        //            }
        //        }
        //        return (nil,code);
    }
}
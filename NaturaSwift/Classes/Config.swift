//
//  Config.swift
//  NaturaSwift
//
//  Created by Manh on 5/26/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
let GOOGLE_PLACE_API:String = "AIzaSyBZyk1C4BckzqzvwjUiAoZTQxN_2TFu3N0";

let SHA1_KEY: String = "W881xNaXSaPbcdOtrRTaM5ZNCp90qc3ti104uLMF"
//MARK: - BASE_API
////PROD

//let BASE_API: String                                       = "https://naturapass.e-conception.fr/api"
//let IMAGE_ROOT_API: String                                 = "https://naturapass.e-conception.fr"
//let LINK_SOCKET: String                                    = "https://naturapass.e-conception.fr"

let BASE_API: String                                       = "https://www.naturapass.com/api"
let IMAGE_ROOT_API: String                                 = "https://www.naturapass.com"
let LINK_SOCKET: String                                    = "https://www.naturapass.com"

//MARK: - API
//*********************** LOGIN **********************************************//
func LOGIN_API(email: String, password: String, deviceId: String, indentifier: String)->String
{
    return "\(BASE_API)/user/login?email=\(email)&password=\(password)&device=\(deviceId)&identifier=\(indentifier)&name=iphone";
}
func REAL_LOGIN(email: String, password:String,pushToken:String) -> String {
    return "\(BASE_API)/user/login?email=\(email)&password=\(password)&device=ios&identifier=\(pushToken)&name=iOS&authorized=0"
}
func REAL_LOGIN_NO_PUSH(email:String, password:String)->String
{
    return "\(BASE_API)/user/login?email=\(email)&password=\(password)&device=ios&identifier=(null)&name=iOS&authorized=0";
}
func FB_LOGIN_API(facebook_id:String,identifier:String) -> String {
    return "\(BASE_API)/user/login?facebookid=\(facebook_id)&device=ios&identifier=\(identifier)&authorized=1&name=iphone";
}
func PUTFACEBOOKUSERACTION_API() -> String {
    return "\(BASE_API)/facebook/email";
}
func POSTFACEBOOKUSERACTION_API() -> String {
    return "\(BASE_API)/facebooks/users";
}
func GET_SQLITE_ALL_POINTS_IN_MAP() -> String {
    return "\(BASE_API)/v2/user/sqlite";
}
//MARK: - PUBLOCATION
func GET_PUBLICATION_FILTEROFF(limit:String, offset: String) -> String {
    return "\(BASE_API)/v2/publication/filteroff?limit=\(limit)&offset=\(offset)";
}
func GETPUBLICATION(limit:String, offset: String,share: String, strGroupAppend: String) -> String {
    return "\(BASE_API)/v2/publications?limit=\(limit)\(share)&offset=\(offset)\(strGroupAppend)";
}
func GETCOMMENT(publication_id:String, publication_limit: String,loadedCount: String) -> String {
    return String(format: "%@/v2/publications/%@/comments?limit=%@&loaded=%@",BASE_API,publication_id,publication_limit,loadedCount);
}
func DELETEPUBLICATIONACTION_API(publication_id:String) -> String {
    return String(format: "%@/publications/%@",BASE_API,publication_id);
}


//MARK: - AGENDA

func GETUSERLOUNGESACTION_API(limit:String, offset: String) -> String {
    return "\(BASE_API)/lounges/owning?limit=\(limit)&offset=\(offset)";
}

//MARK: - GROUP
func GET_MY_GROUPSACTION_API(filter:String,limit:String,offset:String) -> String {
    return String(format:"%@/groups/owning?limit=%@&offset=%@&filter=%@",BASE_API,limit,offset,filter);
}
func GET_GROUP_PUBLICATION(mykind:String,myid:String,limit:String,offset:String) -> String {
    return String(format:"%@/v2/%@/%@/publications?limit=%@&offset=%@",BASE_API,mykind,myid,limit,offset);
}
func GET_ITEM_API(mykind:String,myid:String) -> String {
    return String(format:"%@/%@/%@",BASE_API,mykind,myid);
}
func GET_GROUP_TOUTES_API(filter:String,limit:String, offset: String) -> String {
    return String(format:"%@/groups?limit=%@&offset=%@&filter=%@",BASE_API,limit,offset,filter);
}
func PUT_GROUP_USER_JOIN_API(group_id:String,user_id:String) -> String {
    return String(format:"%@/groups/%@/users/%@/join",BASE_API,group_id,user_id);
}
func POST_GROUP_USER_JOIN_API(group_id:String,user_id:String) -> String {
    return String(format:"%@/groups/%@/joins/%@",BASE_API,user_id,group_id);
}
func GET_GROUP_SUBSCRIBERFRIEND_API(group_id:String) -> String {
    return String(format:"%@/groups/%@/subscribers/friend",BASE_API,group_id);
}
func POST_USER_FRIENDSHIP_API(user_id:String) -> String {
    return String(format:"%@/v2/users/%@/friendships",BASE_API,user_id);
}
func V2_GET_GROUP_INVITATION_API() -> String {
    return String(format:"%@/v2/group/invitation",BASE_API);
}
func PUT_JOIN_KIND_API(mykind:String,group_id:String,user_id:String) -> String {
    return String(format:"%@/%@/%@/users/%@/join",BASE_API,mykind,group_id,user_id);
}
func DELETE_JOIN_KIND_API(mykind:String,mykind_id:String,user_id:String) -> String {
    return String(format:"%@/%@/%@/joins/%@",BASE_API,mykind,user_id,mykind_id);
}
func PUT_GROUP_ACCEPT_INVITATION_API(mykind:String,user_id:String,group_id:String) -> String {
    return String(format:"%@/v1/%@/%@/users/%@/join",BASE_API,mykind,group_id,user_id);
}
func DELETE_GROUP_INVITATION_API(mykind:String,mykind_id:String,user_id:String) -> String {
    return String(format:"%@/v1/%@/%@/joins/%@",BASE_API,mykind,user_id,mykind_id);
}
func GET_ALL_HUNTS_ADMIN() -> String {
    return String(format:"%@/v2/users/hunts/admin",BASE_API);
}
//MARK: - kSQL
 let kSQL_publication:String = "publication"
 let kSQL_shape:String = "shape"
 let kSQL_group:String = "group"
 let kSQL_hunt:String = "hunt"
 let kSQL_distributor:String = "distributor"
 let kSQL_address:String = "address"
 let kSQL_favorite:String = "favorite"

 let kSQL_breed:String = "breed"
 let kSQL_type:String = "type"
 let  kSQL_brand:String = "brand"
 let kSQL_calibre:String = "calibre"

//MARK: - EXTENSION
extension Int {
    func hexString() -> String {
        return NSString(format:"%02x", self) as String
    }
}

extension NSData {
    func hexString() -> String {
        var string = String()
        for i in UnsafeBufferPointer<UInt8>(start: UnsafeMutablePointer<UInt8>(bytes), count: length) {
            string += Int(i).hexString()
        }
        return string
    }
    
    func MD5() -> NSData {
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
        CC_MD5(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(result.mutableBytes))
        return NSData(data: result)
    }
    
    func SHA1() -> NSData {
        let result = NSMutableData(length: Int(CC_SHA1_DIGEST_LENGTH))!
        CC_SHA1(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(result.mutableBytes))
        return NSData(data: result)
    }
}

extension String {
    func hexString() -> String {
        return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.hexString()
    }
    
    func MD5() -> String {
        return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.MD5().hexString()
    }
    
    func SHA1() -> String {
        return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.SHA1().hexString()
    }
}

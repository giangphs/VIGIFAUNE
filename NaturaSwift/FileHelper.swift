//
//  FileHelper.swift
//  NaturaSwift
//
//  Created by Giang on 5/30/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
let  APP_DIRECTORY       = "Naturapass"

class FileHelper: NSObject {
    static let sharedInstance = FileHelper()
    
    var fileManagaer:NSFileManager?
    var documentDir:NSString?
    var filePath:NSString?

    override init() {
        super.init();
        fileManagaer=NSFileManager .defaultManager()
        let dirPaths:NSArray=NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDir=dirPaths[0] as? NSString
        print("path : \(documentDir)")
        
    }

    func copyFileFrom(from: String, to : String)
    {
        
        let copyFile=documentDir?.stringByAppendingPathComponent(to)
        
        if ((fileManagaer?.fileExistsAtPath(copyFile! )) != true) {
            do {
                try fileManagaer?.copyItemAtPath(from, toPath: copyFile!)
            } catch _ {
            }
        }
    }
    class func isfile(filePath: String) -> Bool {
        var isDir: ObjCBool = false;
        let exists: Bool = NSFileManager.defaultManager().fileExistsAtPath(filePath, isDirectory: &isDir)
        if exists {
            /* file exists */
            if isDir {
                /* file is a directory */
                return false
            }
            else {
                return true
            }
        }
        return false
    }
    
    class func isfileExisting(filePath: String) -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(filePath)
    }
    
    class func removeFileAtPath(filePath: String) -> NSError {
        var err: NSError? = nil
        if FileHelper.isfileExisting(filePath) {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePath)
            }
            catch let error as NSError {
                err = error;
            }
            
        }
        return err!
    }
    class func duplicateFileFromPath(filePath: String, toPath targetPath: String) -> NSError {
        var err: NSError? = nil
        do {
            try  NSFileManager.defaultManager().copyItemAtPath(filePath, toPath: targetPath)
        }
        catch let error as NSError {
            err = error;
        }
        
        return err!
    }
    
    class func moveFileAtPath(filePath: String, toPath targetPath: String) -> NSError {
        var err: NSError? = nil
        if FileHelper.isfileExisting(filePath) {
            do {
                try  NSFileManager.defaultManager().moveItemAtPath(filePath, toPath: targetPath)
            }
            catch let error as NSError {
                err = error;
            }
        }
        return err!
    }
    class func createFile(path: String, withData data: NSData, overwrite: Bool) -> NSError {
        var err: NSError? = nil
        if FileHelper.isfileExisting(path) && overwrite {
            err = FileHelper.removeFileAtPath(path)
        }
        if err == nil {
            data.writeToFile(path, atomically: true)
        }
        return err!
    }
    
    class func createFolderAtPath(folderpath: String) -> NSError {
        var err: NSError? = nil
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(folderpath, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError {
            err = error;
        }
        return err!
    }
    class func contentsOfDirectoryAtPath(folderpath: String) -> [AnyObject] {
        var files: [AnyObject]? = nil
        do {
            try  files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(folderpath)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        return files!
    }
    /*
     *Get size for the given file
     */
    class func sizeForFileInBytes(filePath: String) -> NSNumber {
        var size: NSNumber = 0
        if !FileHelper.isfileExisting(filePath) {
            return NSNumber(int: 0);
        }
        do {
            var attributes: [NSObject : AnyObject] = try NSFileManager.defaultManager().attributesOfItemAtPath(filePath)
            size = (attributes[NSFileSize] as! NSNumber)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        return size
    }
    /*
     *Convert Bytes to MegaBytes
     */
    
    class func convertBytesToMegaBytes(bytes: NSNumber) -> NSNumber {
        let result: NSNumber = Int((NSNumber(double:  bytes.doubleValue/1048576.0)))
        return result
    }
    class func temporaryDataDirectory() -> String
    {
        let applicationDataDirectories: NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true);
        var  applicationDataDirectory: String = applicationDataDirectories[0] as! String;
        applicationDataDirectory = applicationDataDirectory.stringByAppendingString("/gif_temporary");
        //Create the directory if it not exist
            if(NSFileManager.defaultManager().fileExistsAtPath(applicationDataDirectory))
            {
                do
                {
                    try NSFileManager.defaultManager().createDirectoryAtPath(applicationDataDirectory, withIntermediateDirectories: true, attributes: nil);
                }
                catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }
            }
        return  applicationDataDirectory;
    }
    class func applicationDataDirectory() -> String
    {
        let applicationDataDirectories: NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true);
        var  applicationDataDirectory: String = applicationDataDirectories[0] as! String;
        applicationDataDirectory = applicationDataDirectory.stringByAppendingString("/\(APP_DIRECTORY)");
        //Create the directory if it not exist
        if(NSFileManager.defaultManager().fileExistsAtPath(applicationDataDirectory))
        {
            do
            {
                try NSFileManager.defaultManager().createDirectoryAtPath(applicationDataDirectory, withIntermediateDirectories: true, attributes: nil);
            }
            catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
            }
        }
        return  applicationDataDirectory;
    }
    class func pathForApplicationDataFile(filename: String) -> String {
        let applicationDataDirectory: String = FileHelper.applicationDataDirectory();
        
        return applicationDataDirectory.stringByAppendingString("/\(filename)");
    }
    class func pathForSecondSplashFile() -> String {
        let applicationDataDirectory: String = FileHelper.applicationDataDirectory();
        return applicationDataDirectory.stringByAppendingString("/AdsSplash.png");
    }
    class func documentSecureDirectory() -> String
    {
        let applicationDataDirectory: String = FileHelper.applicationDataDirectory();
        let  documentSecure: String = applicationDataDirectory.stringByAppendingString("/\(PATH_STORE_CACHE)");
        //Create the directory if it not exist
        if(NSFileManager.defaultManager().fileExistsAtPath(documentSecure))
        {
            do
            {
                try NSFileManager.defaultManager().createDirectoryAtPath(documentSecure, withIntermediateDirectories: true, attributes: nil);
            }
            catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
            }
        }
        return  documentSecure;
    }
    class func documentTempDirectory() -> String
    {
        let applicationDataDirectory: String = FileHelper.applicationDataDirectory();
        let  documentSecure: String = applicationDataDirectory.stringByAppendingString("/\(PATH_STORE_TEMP)");
        //Create the directory if it not exist
        if(NSFileManager.defaultManager().fileExistsAtPath(documentSecure))
        {
            do
            {
                try NSFileManager.defaultManager().createDirectoryAtPath(documentSecure, withIntermediateDirectories: true, attributes: nil);
            }
            catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
            }
        }
        return  documentSecure;
    }
    class func duplicateFiletoAppDataFromBundle(filename: String, toPath strPath: String, overwrite: Bool) -> NSError {
        let ext: String = (filename as NSString).pathExtension
        let name: String = (filename as NSString).stringByDeletingPathExtension
        let bundlepath: String = NSBundle.mainBundle().pathForResource(name, ofType: ext)!
        if bundlepath.characters.count == 0 {
            return NSError(domain: "FileSystem", code: 10000, userInfo: nil);
        }
        var err: NSError? = nil
        if overwrite && FileHelper.isfileExisting(strPath) {
            err = self.removeFileAtPath(strPath)
            if (err == nil) {
                
            }
        }
        err = FileHelper.duplicateFileFromPath(bundlepath, toPath: strPath)
        return err!
    }
}
//
//  UserDefault.swift
//  VoiceRecording
//
//  Created by Sayyam on 18/04/23.
//



import Foundation

//--------------MARK:- NSUserDefaults Extension -
extension UserDefaults
{
    class func SFSDefault(setIntegerValue integer: Int , forKey key : String){
        UserDefaults.standard.set(integer, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func SFSDefault(setObject object: Any , forKey key : String){
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func SFSDefault(setValue object: Any , forKey key : String){
        UserDefaults.standard.setValue(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func SFSDefault(setBool boolObject:Bool  , forKey key : String){
        UserDefaults.standard.set(boolObject, forKey : key)
        UserDefaults.standard.synchronize()
    }
    
    class func SFSDefault(integerForKey  key: String) -> Int{
        let integerValue : Int = UserDefaults.standard.integer(forKey: key) as Int
        UserDefaults.standard.synchronize()
        return integerValue
    }
    
    class func SFSDefault(objectForKey key: String) -> Any{
        let object : Any = UserDefaults.standard.object(forKey: key)! as Any
        UserDefaults.standard.synchronize()
        return object
    }
    
    class func SFSDefault(valueForKey  key: String) -> Any
    {
        
        let value : Any = UserDefaults.standard.value(forKey: key) as Any
        
        UserDefaults.standard.synchronize()
        return value
        
    }
    class func SFSDefault(boolForKey  key : String) -> Bool{
        let booleanValue : Bool = UserDefaults.standard.bool(forKey: key) as Bool
        UserDefaults.standard.synchronize()
        return booleanValue
    }
    
    class func SFSDefault(removeObjectForKey key: String)
    {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}

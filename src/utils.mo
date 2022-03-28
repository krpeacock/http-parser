import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Text "mo:base/Text";

import ArrayModule "mo:array/Array";
import Hex "mo:encoding/Hex";
import Query "mo:http/Query";
import JSON "mo:json/JSON";

module {
    public func textToNat( txt : Text) : Nat {
        assert(txt.size() > 0);
        let chars = txt.chars();
        var num : Nat = 0;
        for (v in chars){
            let charToNum = Nat32.toNat(Char.toNat32(v)-48);
            assert(charToNum >= 0 and charToNum <= 9);
            num := num * 10 +  charToNum;          
        };
        num;
    };

    func charToLowercase(c: Char): Char{
        if (Char.isUppercase(c)){
            let n = Char.toNat32(c);

            //difference between the nat32 values of 'a' and 'A'
            let diff:Nat32 = 32;
            return Char.fromNat32( n + diff);
        };

        return c;
    };

    public func toLowercase(text: Text): Text{
        var lowercase = "";

        for (c in text.chars()){
            lowercase:= lowercase # Char.toText(charToLowercase(c));
        };

        return lowercase;
    };

    public func sliceArray<T>(arr: [T], start: Nat, end: Nat): [T]{
        let len: Nat = if (end > start){end - start} else {0};
        ArrayModule.take((ArrayModule.drop(arr, start)), len)
    };

    public func arrayToBuffer <T>(arr: [T]): Buffer.Buffer<T>{
        let buffer = Buffer.Buffer<T>(arr.size());
        for (n in arr.vals()){
            buffer.add(n);
        };
        return buffer;
    };

    public func enumerate<A>(iter: Iter.Iter<A> ): Iter.Iter<(Nat, A)> {
        var i =0;
        return object{
            public func next ():?(Nat, A) {
                let nextVal = iter.next();

                switch nextVal {
                    case (?v) {
                        i+= 1;
                        ?(i-1, v)
                        };
                    case (_) null;
                };
            };
        };
    };

    public func encodeURIComponent(url: Text): Text{
        ""
    };

    public func decodeURIComponent(url: Text): Text{
        ""
    };

}
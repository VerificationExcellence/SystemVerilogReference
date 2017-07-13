
class MyObject;

   string myState;

   static MyObject myObj;

   // Making constructor local restricts
   // any call to new() outside of the
   // class
   local function new();
   endfunction

   // Creator method
   static function MyObject getObject();
      if(myObj == null)
         myObj = new();
      return myObj;
   endfunction

endclass //MyObject

// Top Module      
module singleton_pattern;

   MyObject anObject;
   MyObject firstObj, secondObj;

   initial
   begin

      // Illegal call to local constructor
      //anObject = new();
 
      firstObj  = MyObject::getObject();
      firstObj.myState = "This is Me!";
      $display("Object Status | First  Object State: %s", firstObj.myState);

      secondObj = MyObject::getObject();
      $display("Object Status | Second Object State: %s", secondObj.myState);
   end

endmodule //singleton_pattern



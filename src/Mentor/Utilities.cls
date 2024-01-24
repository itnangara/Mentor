Class Mentor.Utilities Extends %RegisteredObject
{

ClassMethod FirstGlobal3()
{
    // loop through names
    set n = $order(^PersonI("Name", ""))
    write "n: ", n // "Id: ", id, " DOB: ", dob

    set lastName = "", outputString = ""
    for {
        set lastName = $order(^PersonI("Name", lastName))
        quit:(lastName = "")
        
        set firstName = ""
        for {
            set firstName = $order(^PersonI("Name", lastName, firstName))
            quit:(firstName = "")
            
            // for each Name, loop through ID numbers
            set id = ""
            for {
                set id = $order(^PersonI("Name", lastName, firstName, id))
                quit:(id = "")
                
                // once you have an ID number, get the data and display it
                if $DATA(^PersonI("Name", lastName, firstName, id)) {
                    set rec = ^PersonI("Name", lastName, firstName, id)

                    ; Append values to the output string
                    //Set outputString = outputString _ $ListBuild(lastName, firstName, id) _ ","
                    
                    // fetch phone and DOB data for the current ID
                    set phone = $get(^PersonI("Phone", id))
                    set dob = $get(^PersonI("DOB", id))
                    write "Id: ", id, " DOB: ", dob
                    write "Id: ", id, " DOB: ", dob
                    
                    // display the data
                    write !, lastName, ",", firstName,
                        ?15, phone,
                        ?30, dob, "list: ", $list(rec, 1), "list: ",$list(rec, 1)
                }
            }
        }
    }
}

ClassMethod FirstGlobal2()
{
    // loop through last names
    set ln = "", outputString = ""
    for {
        set ln = $order(^PersonI("Name", ln))
        quit:(ln = "")
        // for each last name, loop through first names
        set fn = ""
        for {
            set fn = $order(^PersonI("Name", ln, fn))
            // Write "fn: ", fn, !
            quit:(fn = "")
            // for each last name and first name, loop through id numbers
            set id = ""
            for {
                set id = $order(^PersonI("Name", ln, fn, id))
                quit:(id = "")
                // once you have an id number, get the data and display it together with last name and first name // if $DATA(^PersonI(id)) {}
                write !, "Last Name: ", ln, ", ",
                    ?15, "First Name: ", fn, ", ",
                    ?30, "ID: ", id, ", "

                Set outputString = outputString _ $ListBuild(ln, fn, id) _ ","
            }
        }
    }

    ; Remove trailing comma
    Set outputString = $Extract(outputString, 1, $Length(outputString) - 1)

    Write "Converted string: ", outputString // $LIST(outputString, ",") // $LTS(outputString)
}

ClassMethod FirstGlobal()
{
    Set Values = $ListBuild(
		$ListBuild("IId", "InId"),
		$ListBuild("Etc", "Etc"),
		$ListBuild("Ap1", "Ap1"),
		$ListBuild("Pineapple", "Pineapple"),
		$ListBuild("DateTimeCreated", "D"),
		$ListBuild("Track", "Track")
	)

    Set ^MyGlobal("IId") = "InId"
    Set ^MyGlobal("Etc") = "Etc"
    Set ^MyGlobal("Ap1") = "Ap1"
    Set ^MyGlobal("Pineapple") = "Pineapple"
    Set ^MyGlobal("DateTimeCreated") = "D"
    Set ^MyGlobal("Track") = "Track"

    Set ValuesFromGlobal1 = $ListBuild(
        $Get(^MyGlobal("IId")),
        $Get(^MyGlobal("Etc")),
        $Get(^MyGlobal("Ap1")),
        $Get(^MyGlobal("Pineapple")),
        $Get(^MyGlobal("DateTimeCreated")),
        $Get(^MyGlobal("Track"))
    )

    Set MyKeys = $ListBuild("IId", "Etc", "Ap1", "Pineapple", "DateTimeCreated", "Track")
    Set ValuesFromGlobal = ""
    Set ValuesFromGlobal = ""
    For i=1:1:$LISTLENGTH(MyKeys) {
        Set Key = $LISTGET(MyKeys, i)
        Set ValuesFromGlobal = ValuesFromGlobal_$GET(^MyGlobal(Key))_","
    }

    Write !, "My 2nd string: ", $LTS(ValuesFromGlobal, ","), !, !


    write !, "My 1st string: ", $lts(Values, ","), !, !
    write !, "My 2nd string: ", $lts(ValuesFromGlobal, ","), !, !

    Set ^PersonI("Bitmap-ID",1) = $zwc(411,1,0)/*$bit(2..5)*/
    Set ^PersonI("DOB", 37105,1) = ""
    Set ^PersonI("DOB", 37110,2) = ""
    Set ^PersonI("DOB", 37779,3) = ""
    Set ^PersonI("DOB", 47157,4) = ""
    Set ^PersonI("Name", "Swoboda","Ron", 3) = ""
    Set ^PersonI("Name", "Agee", "Tommie", 2) = ""
    Set ^PersonI("Name", "ZJones", "Bobby", 4) = ""
    Set ^PersonI("Name", "Jones", "Cleon", 1) = ""
    Set ^PersonI("Phone", "111-111-1111") = 1
    Set ^PersonI("Phone","222-222-2222") = 3
    Set ^PersonI("Phone", "333-444-5555") = 4
    Set ^PersonI("Phone", "617-333-3333") = 2
    
    SET lastName = "Jones"  ; Specify the last name for which you want to display entries
    SET firstName = ""      ; Initialize the first name variable

    FOR {
        SET firstName = $ORDER(^PersonI("Name", lastName, firstName))
        QUIT:firstName=""
        
        SET nodeValue = $GET(^PersonI("Name", lastName, firstName))

        WRITE "Last Name: ", lastName, "  First Name: ", firstName, "  Value: "
        IF $DATA(nodeValue) {
            WRITE nodeValue 
        } ELSE {
            WRITE "No Value"
        }
    WRITE !
    }

    // loop through surnames/lastnames of the ^PersonI global, 2 different ways
    write !, "Using argumentless For"

    Set lastName = $ORDER(^PersonI("Name", ""))
    Write "Last name in ^PersonI: ", lastName

    set ln = ""  // initialize to the empty string to make $Order return the first lastname
    for {        // start looping
        set ln = $order(^PersonI("Name", ln))  // use the current last name to get the next
        quit:(ln = "")                         // stop looping when ln becomes empty again
        write !, ?5, ln
    }
    
    write !!, "Using While"
    set ln = $order(^PersonI("Name", ""))  // get the first last name
    while (ln '= "") {                     // only loop if there is at least one last name
        write !, ?5, ln
        set ln = $order(^PersonI("Name", ln))  // use the current last name to get the next
    }
}

ClassMethod SortList(list As %String) As %String
{
    // Initialize the sorting array
    #; For x=1:1:$Length(list,",") {
    #;     set piece = $Piece(list,",",x)
    #;     if (piece'="") {
    #;         W "1st for lop: "_piece
    #;         Set sorting(piece) = ""
    #;     }

    #;     #; set alphabet(0)="B" 
    #;     #; set alphabet(0)="Z"  
    #;     #; set alphabet(1)="A"  
    #;     #; set alphabet(2)="C"

    #;     #; write "alphabet: "_alphabet(0)
    #;     #; write "alphabet: "_alphabet(1)
    #;     #; write "alphabet: "_alphabet(2)
    #;     //set alphabet(-)="D"
    #; }

    #; // Build the sorted list
    #; Set k="", tempList=""
    #; For {
    #;     Set k = $Order(sorting(k))
    #;     W "2nd for: ", k
    #;     Quit:k=""
    #;     Set tempList = tempList_$ListBuild(k)
    #; }
  
    // Convert the sorted list to a comma-separated string
    //Set sortedList = ","_($ListToString(tempList,","))

    // Convert the input string to a list
    Set listArray = $LISTFROMSTRING(list, ",")

    // Initialize the sorting array
    Set sorting = ""
    For i = 1:1:$LISTLENGTH(listArray) {
        Set piece = $PIECE(listArray(i), ",", 1)
        If piece'="" {
            Set sorting(piece) = ""
        }
    }

    // Build the sorted list
    Set k = "", tempList = ""
    For {
        Set k = $ORDER(sorting(k))
        Quit:k=""
        Set tempList = tempList_$LISTBUILD(k)
    }

    // Convert the sorted list to a comma-separated string
    Set sortedList = ","_$LISTTOSTRING(tempList, ",")

    Quit sortedList
}

/// Description
ClassMethod Multidimensional() As %Status
{
    Set ^MyArray("Alice", "Age") = 25
    Set ^MyArray("John", "Age") = 30
    Set ^MyArray("Bob", "Age") = 35
    Set ^MyArray("Eve", "Age") = 28
    Set ^MyArray("Charlie", "Age") = 32

    set ^month(1) = "January"
    set ^month(2) = "February"
    set ^month(3) = "March"
    set ^month(4) = "April"

    write "first month: ", ^month(4)

    write "<br>","<br>","<br>","<br>"
    Return ""
}

/// Description
ClassMethod TestMeth(list As %String) As %String
{
    Set call = ..SortList(list)
    Return call
}

ClassMethod AddShow(res As %String) As %String
{

    
    Return res
}

/// Description
ClassMethod CheckLimit(list As %String) As %Boolean
{
    Set myString = list

    Set exceedLimit = 0  ; Flag to indicate if any word exceeds 254 characters

    ; Loop through the words separated by commas
    For i=1:1:$LENGTH(myString,",") {
        Set word = $PIECE(myString,",",i)
        If $LENGTH(word) > 7 {
            Set exceedLimit = 1
            Write "Word '", word, "' exceeds maximum limit of characters.", !
            Quit
        }
    }

    If 'exceedLimit {
        // Write "No word exceeds maximum limit of characters in the string."
        Quit 0
    } else {
        // Write "At least one word exceeds maximum limit of characters in the string."
        Quit 1
    }

    Return $$$OK
}

Query OrderedByCode() As %SQLQuery(CONTAINID = 1)
{
SELECT
  %ID,
  Name,
  Email AS "sqlEmail"
  -- Book->%ID AS BookId, -- incase there are any foreign keys with access to fields in other tables
  -- Book->%Name AS BookName -- incase there are any foreign keys with access to fields in other tables
  
  FROM Mentor.Author
  ORDER BY Name || Email  -- concatenates the result of Name & Email then orders the query by the result
}

}

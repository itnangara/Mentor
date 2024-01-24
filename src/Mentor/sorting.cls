Class Mentor.sorting Extends %Persistent
{

ClassMethod SortList(list As %String) As %String
{
    #; // ----------------------------------------
    #; SELECT * FROM ( SELECT %NOLOCK Distinct XISQUALIFICATIONID XISQUALIFICATIONID, QUALIFICATIONSTARTDATE_VALUE QUALIFICATIONSTARTDATEVALUE, QUALIFICATIONENDDATE_VALUE QUALIFICATIONENDDATEVALUE, XISQUALIFICATION.COMMENT XISQUALIFICATIONCOMMENT, XISAPPLICATION->XISAPPLICATIONNAME XISAPPLICATIONXISAPPLICATIONNAME, SYSTEMROLEPROFILELIST SYSTEMROLEPROFILELIST, APPLICATIONID APPLICATIONID, LSP_Utilities.ExportQueries_GetUniqueId($LISTBUILD(LSP_ApplicationRegister_Data.XISQualification.ID, LSP_ApplicationRegister_Data.ApplicationXISQualification.ID, LSP_ApplicationRegister_Data.Application.ID)) AS UniqueId  FROM LSP_ApplicationRegister_Data.XISQualification LEFT JOIN LSP_ApplicationRegister_Data.ApplicationXISQualification ON XISQualification.Guid = ApplicationXISQualification.XISQualification LEFT JOIN LSP_ApplicationRegister_Data.Application ON Application.Guid = ApplicationXISQualification.Application ) :LSP_Utilities.ExportQueries_GetUniqueId($LISTBUILD(LSP_ApplicationRegister_Data.XISQualification.ID, LSP_ApplicationRegister_Data.ApplicationXISQualification.ID, LSP_ApplicationRegister_Data.Application.ID))


    #; SELECT * FROM ( SELECT %NOLOCK Distinct XISQUALIFICATIONID XISQUALIFICATIONID, QUALIFICATIONSTARTDATE_VALUE QUALIFICATIONSTARTDATEVALUE, QUALIFICATIONENDDATE_VALUE QUALIFICATIONENDDATEVALUE, XISQUALIFICATION.COMMENT XISQUALIFICATIONCOMMENT, XISAPPLICATION->XISAPPLICATIONNAME XISAPPLICATIONXISAPPLICATIONNAME, SYSTEMROLEPROFILELIST SYSTEMROLEPROFILELIST, APPLICATIONID APPLICATIONID, LSP_Utilities.ExportQueries_GetUniqueId($LISTBUILD(LSP_ApplicationRegister_Data.XISQualification.ID, LSP_ApplicationRegister_Data.ApplicationXISQualification.ID, LSP_ApplicationRegister_Data.Application.ID)) AS UniqueId  FROM LSP_ApplicationRegister_Data.XISQualification LEFT JOIN LSP_ApplicationRegister_Data.ApplicationXISQualification ON XISQualification.Guid = ApplicationXISQualification.XISQualification LEFT JOIN LSP_ApplicationRegister_Data.Application ON Application.Guid = ApplicationXISQualification.Application )
    #; // ----------------------------------------
    #; // ----------------------------------------
    #; SELECT * FROM ( SELECT %NOLOCK Distinct XISQUALIFICATIONID XISQUALIFICATIONID, QUALIFICATIONSTARTDATE_VALUE QUALIFICATIONSTARTDATEVALUE, QUALIFICATIONENDDATE_VALUE QUALIFICATIONENDDATEVALUE, XISQUALIFICATION.COMMENT XISQUALIFICATIONCOMMENT, XISAPPLICATION->XISAPPLICATIONNAME XISAPPLICATIONXISAPPLICATIONNAME, SYSTEMROLEPROFILELIST SYSTEMROLEPROFILELIST, APPLICATIONID APPLICATIONID, LSP_Utilities.ExportQueries_GetUniqueId($LISTBUILD(LSP_ApplicationRegister_Data.XISQualification.ID, LSP_ApplicationRegister_Data.ApplicationXISQualification.ID, LSP_ApplicationRegister_Data.Application.ID)) AS UniqueId FROM LSP_ApplicationRegister_Data.XISQualification LEFT JOIN LSP_ApplicationRegister_Data.ApplicationXISQualification ON XISQualification.Guid = ApplicationXISQualification.XISQualification LEFT JOIN LSP_ApplicationRegister_Data.Application ON Application.Guid = ApplicationXISQualification.Application ) WHERE LOWER(XISQualificationId) = 'allpurpose'

    #; SELECT * FROM ( SELECT %NOLOCK Distinct XISQUALIFICATIONID XISQUALIFICATIONID, QUALIFICATIONSTARTDATE_VALUE QUALIFICATIONSTARTDATEVALUE, QUALIFICATIONENDDATE_VALUE QUALIFICATIONENDDATEVALUE, XISQUALIFICATION.COMMENT XISQUALIFICATIONCOMMENT, XISAPPLICATION->XISAPPLICATIONNAME XISAPPLICATIONXISAPPLICATIONNAME, SYSTEMROLEPROFILELIST SYSTEMROLEPROFILELIST, APPLICATIONID APPLICATIONID, LSP_Utilities.ExportQueries_GetUniqueId($LISTBUILD(LSP_ApplicationRegister_Data.XISQualification.ID, LSP_ApplicationRegister_Data.ApplicationXISQualification.ID, LSP_ApplicationRegister_Data.Application.ID)) AS UniqueId FROM LSP_ApplicationRegister_Data.XISQualification LEFT JOIN LSP_ApplicationRegister_Data.ApplicationXISQualification ON XISQualification.Guid = ApplicationXISQualification.XISQualification LEFT JOIN LSP_ApplicationRegister_Data.Application ON Application.Guid = ApplicationXISQualification.Application ) WHERE LOWER(XISQualificationId) = 'allpurpose'
    #; // ----------------------------------------
    #; // ----------------------------------------
    #; // 1st Query: Page display
    #; SELECT * FROM ( SELECT %NOLOCK Distinct XISQUALIFICATION.GUID 
    #; H_XISQUALIFICATIONGUID, XISQUALIFICATIONID XISQUALIFICATIONID, QUALIFICATIONSTARTDATE_VALUE QUALIFICATIONSTARTDATEVALUE, QUALIFICATIONENDDATE_VALUE QUALIFICATIONENDDATEVALUE, XISQUALIFICATION.COMMENT XISQUALIFICATIONCOMMENT, XISAPPLICATION->XISAPPLICATIONNAME XISAPPLICATIONXISAPPLICATIONNAME, SYSTEMROLEPROFILELIST SYSTEMROLEPROFILELIST
    #; FROM LSP_ApplicationRegister_Data.XISQualification 
    #; LEFT JOIN LSP_ApplicationRegister_Data.ApplicationXISQualification ON XISQualification.Guid = ApplicationXISQualification.XISQualification
    #; LEFT JOIN LSP_ApplicationRegister_Data.Application ON Application.Guid = ApplicationXISQualification.Application ) 
    #; ORDER BY Lower(XISQualificationId)

    #; // 2nd Query: Export display
    #; SELECT * FROM ( SELECT %NOLOCK Distinct XISQUALIFICATIONID
    #; XISQUALIFICATIONID, QUALIFICATIONSTARTDATE_VALUE QUALIFICATIONSTARTDATEVALUE, QUALIFICATIONENDDATE_VALUE QUALIFICATIONENDDATEVALUE, XISQUALIFICATION.COMMENT XISQUALIFICATIONCOMMENT, XISAPPLICATION->XISAPPLICATIONNAME XISAPPLICATIONXISAPPLICATIONNAME, SYSTEMROLEPROFILELIST SYSTEMROLEPROFILELIST, APPLICATIONID APPLICATIONID, LSP_Utilities.ExportQueries_GetUniqueId($LISTBUILD(LSP_ApplicationRegister_Data.XISQualification.ID, LSP_ApplicationRegister_Data.ApplicationXISQualification.ID, LSP_ApplicationRegister_Data.Application.ID)) AS UniqueId 
    #; FROM LSP_ApplicationRegister_Data.XISQualification
    #; LEFT JOIN LSP_ApplicationRegister_Data.ApplicationXISQualification ON XISQualification.Guid = ApplicationXISQualification.XISQualification
    #; LEFT JOIN LSP_ApplicationRegister_Data.Application ON Application.Guid = ApplicationXISQualification.Application )  WHERE LOWER(XISQualificationId) = 'allpurpose' ORDER BY Lower(XISQualificationId)

    #; // 3nd Query: Export MGR display
    #; SELECT * FROM ( SELECT %NOLOCK Distinct XISQUALIFICATIONID XISQUALIFICATIONID, QUALIFICATIONSTARTDATE_VALUE QUALIFICATIONSTARTDATEVALUE, QUALIFICATIONENDDATE_VALUE QUALIFICATIONENDDATEVALUE, XISQUALIFICATION.COMMENT XISQUALIFICATIONCOMMENT, XISAPPLICATION->XISAPPLICATIONNAME XISAPPLICATIONXISAPPLICATIONNAME, SYSTEMROLEPROFILELIST SYSTEMROLEPROFILELIST, APPLICATIONID APPLICATIONID, LSP_Utilities.ExportQueries_GetUniqueId($LISTBUILD(LSP_ApplicationRegister_Data.XISQualification.ID, LSP_ApplicationRegister_Data.ApplicationXISQualification.ID, LSP_ApplicationRegister_Data.Application.ID)) AS UniqueId
    #; FROM LSP_ApplicationRegister_Data.XISQualification
    #; LEFT JOIN LSP_ApplicationRegister_Data.ApplicationXISQualification ON XISQualification.Guid = ApplicationXISQualification.XISQualification
    #; LEFT JOIN LSP_ApplicationRegister_Data.Application ON Application.Guid = ApplicationXISQualification.Application )
    #; WHERE LOWER(XISQualificationId) = 'all.mlc.rvp.vus.2012'
    #; ORDER BY XISQualificationId
    #; // ----------------------------------------



    // Initialize the sorting array
    For x=1:1:$Length(list,",") {
        set piece = $Piece(list,",",x)
        if (piece'="") {
            Set sorting(piece) = ""
        }

        /*
            Set Item = $LIST(Items, i)
            Set Value = $LISTGET(Item, 1)
            Set Display = $LISTGET(Item, 2)


            <script language=cache method=ColumnSelection arguments="" returntype="%String" procedureblock>
	Set Items = $LISTBUILD( 
					$LISTBUILD("second", "second"),
					$LISTBUILD("second2", "second2"), 
					$LISTBUILD("second3", "second3"),
					$LISTBUILD("second4", "second4"),
					$LISTBUILD("second5", "second5")
				)
	
	Set Result = "<select name=Fields><option value="""">&nbsp;</option>"
	
	For i = 1 : 1 : $LISTLENGTH(Items)
	{
		Set Item = $LIST(Items, i)
		Set Value = $LISTGET(Item, 1)
		Set Display = $LISTGET(Item, 2)
		
		Set Result = Result _ "<option value=""" _ $ZCONVERT(Value, "O", "HTML") _ """"
		
		If %request.Get("Fields") = Value
		{
			Set Result = Result _" selected"
		}
		
		Set Result = Result _ ">" _ $ZCONVERT(Display,"O","HTML") _ "</option>"
	}
	
	Set Result = Result _ "</select>"
	
	Quit Result
</script>

			write "value of i: "_i_" key: "_Key_"<br>"

            write "value: "_Value_"<br>"
			write "value of i: "_i_" key: "_Key_"<br>"

            write "class testing Result: "_Result_" ending"_"<br>"

            No args  -> Query:  SELECT %NOLOCK * , LSP_Log.SystemLog_ShowArguments(ID) as Arguments FROM LSP_Log.SystemLog WHERE Timestamp >= '2020-12-12'
            Wth args -> Query:  SELECT %NOLOCK a.* , LSP_Log.SystemLog_ShowArguments(a.ID) as Arguments FROM LSP_Log.SystemLog a left join LSP_Log.SystemLog_Arguments b on a.id = b.SystemLog WHERE b.element_key = ''
                                AND b.Arguments LIKE 'CurrentClass: csp.events.lijst.notifysubscriptionlog CurrentMethod: BuildQuery ErrorText: Query 1: SELECT * FROM LSP_LOG.Notification'
                                AND a.Timestamp >= '2020-12-12' 
                                
            Wth args -> Query:  SELECT %NOLOCK a.* , Mentor.Book_ShowLists(a.ID) as Arguments FROM Mentor.Book a left join Mentor.Book_ShowLists b on a.id = b.Book WHERE b.el_key = ''
                                AND b.Arguments LIKE 'CurrClass: csp.ShowBooks CurrMethod: BuildQuery ErrText: Query 1: SELECT * FROM Mentor.HistoryLog'
                                AND a.Timestamp >= '2020-12-12' 


            SELECT %NOLOCK * , Mentor.Book_ShowLists(ID) as List FROM Mentor.Book
            SELECT %NOLOCK ID, Title, Author, Mentor.Book_ShowLists(ID) as List FROM Mentor.Book

            -> result set that returns props and additional property that is not persistent (list)
            -> this list is calculated on the fly using a function, and ofcourse passing an ID
        */

        /*
            set alphabet(0)="B" 
            set alphabet(0)="Z"  
            set alphabet(1)="A"  
            set alphabet(3)="C"

            write "alphabet: "_alphabet(0)
            write "alphabet: "_alphabet(1)
            write "alphabet: "_alphabet(3)
            //set alphabet(-)="D"
        */
    }

    // Build the sorted list
    Set k="", tempList=""
    For {
        Set k = $Order(sorting(k))
        Quit:k=""
        Set tempList = tempList_$ListBuild(k)
    }

    // Convert the sorted list to a comma-separated string
    Set sortedList = ","_($ListToString(tempList,","))

    Quit sortedList
}

ClassMethod MultidimensionalArray() As %Status
{
    Set ^MyArray("Alice", "Age") = 25
    Set ^MyArray("John", "Age") = 30
    Set ^MyArray("Bob", "Age") = 35
    Set ^MyArray("Eve", "Age") = 28
    Set ^MyArray("Charlie", "Age") = 32

    #; Set name = ""
    #; While $Order(^MyArray(name, "Age"))'="" {
    #;     Write "Name: ", name, ", Age: ", ^MyArray(name, "Age"), !
    #;     Set name = $Order(^MyArray(name, "Age"))
    #; }

    #; Set name = ""
    #; While $Order(^MyArray(name, "Age"))'="" {
    #;     Write "Name: ", $Order(^MyArray(name, "Age")), ", Age: ", ^MyArray($Order(^MyArray(name, "Age")), "Age"), !
    #;     Set name = $Order(^MyArray(name, "Age"))
    #; }

    Set name = ""
    While $Order(^MyArray(name, "Age"))'="" {
        Set name = $Order(^MyArray(name, "Age"))
        Write "Name: ", name, ", Age: ", ^MyArray(name, "Age"), !
    }

    Quit 1
}

ClassMethod SortDoubleList(list As %String) As %String
{
    Set Values=$ListBuild(
        $ListBuild("1st", "first"),
        $ListBuild("3rd", "third"),
        $ListBuild("2nd", "second"),
        $ListBuild("4th", "forth"),
        $ListBuild("8th", "eigth"),
        $ListBuild("9th", "nineth"),
        $ListBuild("11th", "eleventh"),
    )

    write "Values given", Values

    // Initialize the sorting array
    For x=1:1:$Length(list,",") {
        set piece = $Piece(list,",",x)
        if (piece'="") {
            Set sorting(piece) = ""
        }

        /*
            set alphabet(0)="B" 
            set alphabet(0)="Z"  
            set alphabet(1)="A"  
            set alphabet(3)="C"

            write "alphabet: "_alphabet(0)
            write "alphabet: "_alphabet(1)
            write "alphabet: "_alphabet(3)
            //set alphabet(-)="D"
        */
    }

    // Build the sorted list
    Set k="", tempList=""
    For {
        Set k = $Order(sorting(k))
        Quit:k=""
        Set tempList = tempList_$ListBuild(k)
    }

    // Convert the sorted list to a comma-separated string
    Set sortedList = ","_($ListToString(tempList,","))

    Quit sortedList
}

/// Description
ClassMethod TestMeth(list As %String) As %String
{
    Set call = ..SortList(list)
    Return call
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

Storage Default
{
<Data name="SortingDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^CONCEPTS.SortingD</DataLocation>
<DefaultData>SortingDefaultData</DefaultData>
<IdLocation>^CONCEPTS.SortingD</IdLocation>
<IndexLocation>^CONCEPTS.SortingI</IndexLocation>
<StreamLocation>^CONCEPTS.SortingS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

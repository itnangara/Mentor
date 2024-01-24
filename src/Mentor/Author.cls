Class Mentor.Author Extends %Persistent
{

Property Name As %String;

Property Email As %String;

Property Gender As %String;

// Property Authors As list of Mentor.Author;

Index AuthorName On Name [ Unique ];

// BookAuthor

Relationship Bridge As Mentor.BookAuthor [ Cardinality = many, Inverse = Author ];

Query GetAllAuthors() As %SQLQuery [ SqlProc ]
{
    SELECT *
    FROM Mentor.Author
}

ClassMethod AddAuthor(objString) As %Status
{
    set result = {}
    set result = result.%FromJSON(objString)

    Set booksArray = result.BooksValue
    Set iterator = booksArray.%GetIterator()
    
    Try {
        if (result '= "") {            
            // create a new Author
            Set author = ##class(Mentor.Author).%New()
            Set author.Name = result.Name
            Set author.Email = result.Email
            Set author.Gender = result.Gender
            if (result.BooksValue.%Size()<=0) {
                Set status = author.%Save()
            } else {
                // Iterate through ** UI Books **
                While iterator.%GetNext(.key, .obj){
                    Set book = ##class(Mentor.Book).%OpenId(obj.ID)
                    If book '= "" {
                        Set authorBook = ##class(Mentor.BookAuthor).%New()
                        Set authorBook.Author = author
                        Set authorBook.Book = book
                        Set status = authorBook.%Save()
                    }
                }
            }
        }
    }

    Catch (err) {
        Set %response.Status = 500
        return {"errormessage":"Server Error"}
    }
}

ClassMethod EditAuthor(objString) As %Status
{
    set result = {}
    set result = result.%FromJSON(objString)
    set authorId = result.ID

    Set author = ##class(Mentor.Author).%OpenId(authorId)
    Set author.Name = result.Name
    Set author.Email = result.Email
    Set author.Gender = result.Gender
    Set status = author.%Save()

    if author '= "" {
        Set existingBookTitles = [] // tracking existing books from DB
        Set bookAuthorList = author.Bridge // list of Books array/list reference
        For i = 1:1:bookAuthorList.Count() {
            Set bookAuthor = bookAuthorList.GetAt(i)
            Set book = bookAuthor.Book
            Set existingBookTitles(book.Name) = 1
        }

        Set booksArray = result.BooksValue
        Set iterator = booksArray.%GetIterator()
        Set dbBooksRemover = []

        // Iterate through ** UI Books **
        While iterator.%GetNext(.key, .obj){
            Set dbBooksRemover(obj.Name) = obj.ID
            Set bookName = obj.Name
            If $Data(existingBookTitles(bookName)) {
            } else {
                // The book is not referenced to the current author, create a new reference
                Set book = ##class(Mentor.Book).%OpenId(obj.ID)
                If book '= "" {
                    Set authorBook = ##class(Mentor.BookAuthor).%New()
                    Set authorBook.Author = author
                    Set authorBook.Book = book
                    Set sc = authorBook.%Save()
                }
            }
        }
        
        // Removing books that were unchecked
        Set newBookAuthorList = author.Bridge
        if (newBookAuthorList.Count() > 0) {
            For i=1:1:newBookAuthorList.Count() {
                Set bookAuthor = newBookAuthorList.GetAt(i)
                If $Data(dbBooksRemover(bookAuthor.Book.Name)) {
                } else {
                    set status = ##class(Mentor.BookAuthor).%DeleteId(bookAuthor.%Id())
                }
            }
        }
    }
}

Query GetAuthorByName(Name As %String) As %SQLQuery [ SqlProc ]
{
    SELECT *
    FROM Mentor.Author
    WHERE Name = :Name
}

Query GetAuthor(ID As %String) As %SQLQuery [ SqlProc ]
{
    SELECT *
    FROM Mentor.Author
    WHERE ID = :ID
}

ClassMethod AuthReturn() As %Status
{
    Set authors = ##class(%SQL.Statement).%ExecDirect("SELECT * FROM Mentor.Author") 

    Return authors
}

ClassMethod bookAuthorReturn() As %Status
{
    Set bookAuthor = ##class(%SQL.Statement).%ExecDirect("SELECT * FROM Mentor.BookAuthor") 

    Return bookAuthor
}

ClassMethod BookReturn() As %Status
{
    Set author = ##class(Mentor.Author).%OpenId("1")

    Return author
}

ClassMethod RelTest() As %Status
{
    Set authors = ##class(%SQL.Statement).%ExecDirect("SELECT * FROM Mentor.Author") 
    Set bookAuthor = ##class(%SQL.Statement).%ExecDirect("SELECT * FROM Mentor.BookAuthor") 
    
    #; Set author = ##class(Mentor.Author).%OpenId("2")

    #; write "author: ", author
    #; write "bookAuthor: ", bookAuthor

    #; Set ab1 = author.Bridge // 2
    #; Set ab2 = author.Bridge

    // retrieve all authors
    // for an author, retrieve the books related
    // BA:1, B:24, A:45

    Set author = ##class(Mentor.Author).%OpenId("2")
    set i = 0
    while i<author.Bridge.Count() {
        write author.Bridge.GetAt(i) 
        set i = i + 1
    }

    Return $$$OK
}

Query GetAuthorsWithBooks() As %SQLQuery [ SqlName = AuthorList, SqlProc ]
{
    SELECT
        a.Id AS AuthorId,
        a.Name AS AuthorName,
        b.Name AS BookTitle
    FROM
        Mentor.Author a
    LEFT JOIN
        Mentor.BookAuthor ba ON a.ID = ba.ID
    LEFT JOIN
        Mentor.Book b ON ba.ID = b.ID
}

ClassMethod GetAuthorDetails(ID As %String) As %Status
{
    Set author = ##Class(Mentor.Author).%OpenId(ID)
    
    If (author '= "") {
        Set result = {}
        set result.ID = ID // do not do author.ID because ID is not a class property of Author
        set result.Name = author.Name
        set result.Email = author.Email
        set result.Gender = author.Gender

        Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Mentor.BookAuthor WHERE Author = :ID")
        While rs.%Next() {
            Write rs.Name, !
        }

        //Set result.BooksValue = 


        #; Set s = {}
        #; Set bookAuthors = author.Bridge.Book
        #; For i = 1:1:2 {
        #;     Set bookAuthor = bookAuthors.GetAt(i)  // Get the individual BookAuthor relationship object
            
        #;     #; // Access the associated author and book objects directly
        #;     #; Set authorId = bookAuthor.Author.Id  // Access the ID of the associated author
        #;     #; Set bookId = bookAuthor.Book.Id      // Access the ID of the associated book

        #;     #; Write "Author ID: ", authorId, !
        #;     #; Write "Book ID: ", bookId, !
        #; }
        #; write getAt(1)

        #; Write "Book test: ", book.%ToJSON()

        #; Set bridge = author.Bridge // Access the bridging table
    }
    return result.%ToJSON()
}

/// Method to delete an Author
ClassMethod DeleteAuthor(ID As %String) As %Status
{
    Try {
        if (ID '= "") {
            Set curentAuthor = ##class(Mentor.Author).%OpenId(ID)
            Set authorBookList = curentAuthor.Bridge
            
            For i=1:1:authorBookList.Count() {
                Set bookAuthor = authorBookList.GetAt(i)
                Set status = ##class(Mentor.BookAuthor).%DeleteId(bookAuthor.%Id())
            }
            
            If curentAuthor '= "" {
                set status = ##class(Mentor.Author).%DeleteId(ID)
            }
        }
    }
    Catch err {
        set %response.Status = 500
        return {"error message":"Server Error"}
    }
    return $$$OK
}

Storage Default
{
<Data name="AuthorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Email</Value>
</Value>
<Value name="4">
<Value>Gender</Value>
</Value>
</Data>
<DataLocation>^Mentor.AuthorD</DataLocation>
<DefaultData>AuthorDefaultData</DefaultData>
<ExtentSize>9</ExtentSize>
<IdLocation>^Mentor.AuthorD</IdLocation>
<IndexLocation>^Mentor.AuthorI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Email">
<AverageFieldSize>17.33</AverageFieldSize>
<Selectivity>11.1111%</Selectivity>
</Property>
<Property name="Gender">
<AverageFieldSize>6.33</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>8.33</AverageFieldSize>
<Selectivity>11.1111%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Mentor.AuthorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

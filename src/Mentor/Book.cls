Class Mentor.Book Extends %Persistent
{

Property Name As %String;

Index BookName On Name [ Unique ];

/// Relationship property to hold instances of the book class
Relationship Bridge As Mentor.BookAuthor [ Cardinality = many, Inverse = Book ];

Query GetAllBooks() As %SQLQuery [ SqlProc ]
{
    SELECT *
    FROM Mentor.Book
}

Query GetBookByName(Name As %String) As %SQLQuery [ SqlProc ]
{
    SELECT *
    FROM Mentor.Book
    WHERE Name = :Name
}

ClassMethod AddBook(objString) As %Status
{
    set result = {}
    set result = result.%FromJSON(objString)
    
    Set authorsArray = result.AuthorsValue
    Set iterator = authorsArray.%GetIterator()
    
    Try {
        if (result '= "") {            
            // create a new Book
            Set book = ##class(Mentor.Book).%New()
            Set book.Name = result.Name
            
            if (result.AuthorsValue.%Size()<=0) {
                Set status = book.%Save()
            } else {
                // Iterate through ** UI Authors **
                While iterator.%GetNext(.key, .obj){
                    Set author = ##class(Mentor.Author).%OpenId(obj.ID)
                    If author '= "" {
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

ClassMethod EditBook(jsonString) As %Status
{
    set result = {}
    set result = result.%FromJSON(jsonString)
    set authorId = result.ID
    Set book = ##class(Mentor.Book).%OpenId(authorId)
    Set book.Name = result.Name
    Set status = book.%Save()

    if book '= "" {
        Set existingAuthorDetails = [] // tracking existing authors from DB
        Set bookAuthorList = book.Bridge // list of Books array/list reference
        For i = 1:1:bookAuthorList.Count() {
            Set bookAuthor = bookAuthorList.GetAt(i)
            Set author = bookAuthor.Author
            Set existingAuthorDetails(author.Name) = 1
        }

        Set authorsArray = result.AuthorsValue
        Set iterator = authorsArray.%GetIterator()
        Set dbBooksRemover = []

        // Iterate through ** UI Authors **
        While iterator.%GetNext(.key, .obj){
            Set dbBooksRemover(obj.Name) = obj.ID
            Set authorName = obj.Name
            If $Data(existingAuthorDetails(authorName)) {
            } else {
                // The author is not referenced to the current book, create a new reference
                Set author = ##class(Mentor.Author).%OpenId(obj.ID)
                If author '= "" {
                    Set authorBook = ##class(Mentor.BookAuthor).%New()
                    Set authorBook.Author = author
                    Set authorBook.Book = book
                    Set sc = authorBook.%Save()
                }
            }
        }

        // Removing authors that were unchecked
        Set newBookAuthorList = book.Bridge
        if (newBookAuthorList.Count() > 0) {
            For i=1:1:newBookAuthorList.Count() {
                Set bookAuthor = newBookAuthorList.GetAt(i)
                If $Data(dbBooksRemover(bookAuthor.Author.Name)) {
                } else {
                    set status = ##class(Mentor.BookAuthor).%DeleteId(bookAuthor.%Id())
                }
            }
        }
    }
    return $$$OK
}

ClassMethod GetBookDetails(ID As %String) As %Status
{
    set book = ##class(Mentor.Book).%OpenId(ID)
    set result = {}
    set result.ID = ID
    set result.Name = book.Name
    
    Return result.%ToJSON()
}

/// Method to delete a book
ClassMethod DeleteBook(ID As %String) As %Status
{
    Try {
        if (ID '= "") {
            Set curentBook = ##class(Mentor.Book).%OpenId(ID)
            Set authorBookList = curentBook.Bridge
            if (authorBookList.Count() > 0) {
                For i=1:1:authorBookList.Count() {
                    Set bookAuthor = authorBookList.GetAt(i)
                    Set status = ##class(Mentor.BookAuthor).%DeleteId(bookAuthor.%Id())
                }
            }
            
            If curentBook '= "" {
                set status = ##class(Mentor.Book).%DeleteId(ID)
            }
        }
    }
    Catch err {
        set %response.Status = 500
        return {"error message":"Server Error"}
    }
    return $$$OK
}

// ClassMethod MethodName() As %Status [ CodeMode = generator ]

// {

//     Set sc = $$$OK

//     #; Set Author = ##Class(Mentor.Author).AuthorNameOpen("J Wolf", .sc)

//     If '("") {

//         Set Author = ##Class(Mentor.Author).%New()

//         Set Author.Name = "J wolf"

//         Do Author.%Save()

//     }

//     #Dim self As Mentor.Book

//     Do ..%DeleteExtent()

//     For BookName="How to be a kickass mentor", "How to be one with oneself", "How to cook dinner when you live alone", "Inner peace" {

//         Set self = ..%New()

//         Set self.Name = BookName

//         Set self.Author = Author

//         Do self.%Save()

//     }

//     Return sc

// }

Storage Default
{
<Data name="BookDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Author</Value>
</Value>
</Data>
<DataLocation>^Mentor.BookD</DataLocation>
<DefaultData>BookDefaultData</DefaultData>
<IdLocation>^Mentor.BookD</IdLocation>
<IndexLocation>^Mentor.BookI</IndexLocation>
<StreamLocation>^Mentor.BookS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

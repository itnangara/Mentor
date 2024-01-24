Class Mentor.BookAuthor Extends %Persistent
{

/// Author property OREF
Relationship Author As Mentor.Author [ Cardinality = one, Inverse = Bridge ];

/// Index for Author Objects
Index AuthorIndex On Author;

/// Book property OREF
Relationship Book As Mentor.Book [ Cardinality = one, Inverse = Bridge ];

/// Index for Book Objects
Index BookIndex On Book;

// Property Author As Mentor.Author;

// ForeignKey AuthorFK(Author) References Mentor.Author();

// Property Book As Mentor.Book;

// ForeignKey BookFK(Book) References Mentor.Book();

Storage Default
{
<Data name="BookAuthorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Author</Value>
</Value>
<Value name="3">
<Value>Book</Value>
</Value>
</Data>
<DataLocation>^Mentor.BookAuthorD</DataLocation>
<DefaultData>BookAuthorDefaultData</DefaultData>
<IdLocation>^Mentor.BookAuthorD</IdLocation>
<IndexLocation>^Mentor.BookAuthorI</IndexLocation>
<StreamLocation>^Mentor.BookAuthorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

Class Mentor.Records Extends %Persistent
{

Property Name As %String;

Property Id As %String;

Property bookData As list Of Mentor.Book;

Property authorData As list Of Mentor.Author;

Storage Default
{
<Data name="RecordsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Id</Value>
</Value>
<Value name="4">
<Value>bookData</Value>
</Value>
<Value name="5">
<Value>authorData</Value>
</Value>
</Data>
<DataLocation>^Mentor.RecordsD</DataLocation>
<DefaultData>RecordsDefaultData</DefaultData>
<IdLocation>^Mentor.RecordsD</IdLocation>
<IndexLocation>^Mentor.RecordsI</IndexLocation>
<StreamLocation>^Mentor.RecordsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

# Custom business card decoder with Flex and Bison

The 'card.card' contains three business card example.

The following attributes are available for a contact:
```
Name
Address
Email
Phone
Title
Company
CompanyAddress
CompanyEmail
CompanyPhone
```

The grammar is very similar to JSON. One object '{}' represents one business card.
You can pass one value to an attribute, or you can pass multiple value to an attribute:
```
{"Name":"John Doe", "Phone":["+36-55-478-5412","+36-66-636-480"]}
```

Running the above example will result in the following:
```
Contact 1:
Name: John Doe
Phone: +36-55-478-5412 +36-66-636-480
```

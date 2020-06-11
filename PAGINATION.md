Pagination
--------

For cursor pagination, you need to define a connection for the model you are querying.

For example if you need to return the collection of all the User records in the app:
```
  field :users_connection, Types::CustomTypes::UserType.connection_type, null: false

  def users_connection
    User.all
  end
```
With this defined, the query would need to have the following structure:
```
query {
  usersConnection {
    edges {
      node {
        id
        firstName
      }
    }
  }
}
```
and the response will have this structure:
```
{
  "data": {
    "userConnection": {
      "edges": [
        {
          "node": {
            "id": "1",
            "firstName": "Myesha",
            "lastName": "Stoltenberg"
          }
        },
        {
          "node": {
            "id": "2",
            "firstName": "Oscar",
            "lastName": "Kozey"
          }
        }
      ]
    }
  }
}
````
With this set up we can request useful information for pagination

at the connection level:
```
  pageInfo {

    startCursor: the cursor of the first returned value

    endCursor: the cursor of the last returned value

    hasPreviousPage: a boolean indicating if there are records before the first cursor

    hasNextPage: a boolean indicating if there are records after the last cursor
  }

  totalCount: number of values that the collection contains

```

in the node level:
```
  cursor: the cursor of the actual node
```

Adding this to the request would look something like:
```
query {
  usersConnection{
    pageInfo {
      startCursor
      endCursor
      hasPreviousPage
      hasNextPage
    }
    edges {
      cursor
      node {
        id
        firstName
        lastName
      }
    }
    totalCount
  }
}
```
with this response:
```
{
  "data": {
    "usersConnection": {
      "pageInfo": {
        "startCursor": "MQ",
        "endCursor": "Mw",
        "hasPreviousPage": false,
        "hasNextPage": true
      },
      "totalCount": 21,
      "edges": [
        {
          "node": {
            "id": "1",
            "firstName": "Myesha",
            "lastName": "Stoltenberg"
          },
          "cursor": "MQ"
        },
        {
          "node": {
            "id": "2",
            ...
      ]
    }
  }
}
```

Finally, the connection could receive some values as parameters to customize de response for only returning the desirable records.

`first: int` returns the first given number of records
`last: int` returns the last given number of records
`after: String` returns the records after the given cursor
`before: String` returns the records before the given cursor

For example: `usersConnection(first: 5 after: "Mw"){ ... }` returns the first 5 records after the node with the "Mw" cursor.


It's important to take into account that `hasPreviousPage` would always be false unless you are paginating forward (`UserConnection(first: 5)`), and `hasNextPage` would always be false unless paginating backward (`UserConnection(last: 5)`). This is not an implementation error, it's due to how connections are designed.

If you need the hasPreviosPage value when paginating forward, you could make an additional query requesting the last 0 values before the node of which we want to know if there are values before:
```
query {
  userConnection(last: 0, before: "MQ") {
    pageInfo {
      hasPreviousPage
    }
  }
}
```
or the first 0 values after the desired node when we want to know if it `hasNextPage` while paginating backward.

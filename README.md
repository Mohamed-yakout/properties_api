# Properties API

### How to install the properties api on the server.

- Clone the api on the server or localhost.
- Make sure you installed rvm, then create `.ruby-gemset` on the folder, and type the gemset name.
- After creating the gemset, install the bundler by `gem install bundler`.
- Install all required gems by command: `bundle install`.
- Create new Database by command: `rake db:create`.
- Clone the default database by command: `psql database_name < ./data/properties.sql`.
- Migrate all other indexing to DB: `rake db:migrate`.
- Start the server by: `rails s`.

### Use the API, and sample of responses

- To call the service, send GET request to `http://0.0.0.0:3000/properties` or `http://0.0.0.0:3000`.
- Also, search params contains mandatory params, and optional params.

1. Mandatory Params: lat & lng, so the request should be as the following: `?lng=13.4236807&lat=52.5342963`

In case the URL doesn't have these params, the response will be:
```
{
    "errors": {
        "base": [
            {
                "Validate::FilterLocation": {
                    "latitude": [
                        "can't be blank",
                        "is not a number"
                    ],
                    "longitude": [
                        "can't be blank",
                        "is not a number"
                    ]
                }
            }
        ]
    }
}
```

2. Optional params are `property_type=apartment&marketing_type=sell`,

- these params can be NULL.
- `property_type` is just either `apartment` or `single_family_house`
- `marketing_type` is either `rent` or `sell`

in case the values not included in the expected list, the following will be the error:

```
{
    "errors": {
        "base": [
            {
                "Validate::FilterType": {
                    "marketing_type": [
                        "is not included in the list"
                    ],
                    "property_type": [
                        "is not included in the list"
                    ]
                }
            }
        ]
    }
}
```

3. In case the given params hasn't results in the 5KM radius, the response will be:

```
{
    "message": "No Data"
}
```

4. Success response will be as the following:

```
[
    {
        "id": 326809,
        "house_number": "36",
        "offer_type": "sell",
        "property_type": "apartment",
        "lng": "13.4224666",
        "lat": "52.5346344",
        "zip_code": "10405",
        "city": "Berlin",
        "street": "Prenzlauer Allee",
        "price": "239500.0"
    },
    {
        "id": 5419138,
        "house_number": null,
        "offer_type": "sell",
        "property_type": "apartment",
        "lng": "13.4225659",
        "lat": "52.5327964",
        "zip_code": "10405",
        "city": "Berlin",
        "street": null,
        "price": "142900.0"
    },
]
```

### Calculate the distance among properties

- This api use `activerecord-postgres-earthdistance` to calculate the distance between the given location, and the properties.
- `activerecord-postgres-earthdistance` is using `ll_to_earth` and `earth_distance` in postgresql.
- Indexing `earthdistance` in property model to make the query fast.
- [activerecord-postgres-earthdistance gem](https://github.com/diogob/activerecord-postgres-earthdistance) for more details.

### Validate search params

- There is main class `FullValidation` which is responsible to call all filter classes.
- Filter classes:
1. `FilterParams`: responsible to make sure no extra search params in the request.
2. `FilterLocation`: responsible to make sure location filter params are exist, and in correct format.
3. `FilterType`: responsible to validate the other search params.

### Scale cases:

1. Limit result by using pagination, [will_paginate gem](https://github.com/mislav/will_paginate) can be installed to limit the results.

2. Adding other search params in the service as (number_of_rooms/construction_year/currency).

In this case we will need to add it in `FilterParams` & `FilterType`, and define new scopes to apply the new filters.

3. Different currencies exist in database, then in this case we need to integrate with currency mapping api.
and override the price attribute in the Serializer to make sure all prices return in euro currency.

### Run test cases

1. run command: `rails test`, all test cases are passed.
2. Test cases are responsible to confirm the following:

* lat & lng params are mandatory in the properties request.
* property_type & marketing_type are optional search params.
* property_type & marketing_type should included in the default list.
* closest properties to the given location should all in distance less than 5 KM.
* receive 404 status_code in case no data found for given filter params.

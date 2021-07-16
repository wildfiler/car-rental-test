# Car rental service API

## Car endpoints

### Create car

`POST /cars`

Parameters:
- car - [Hash] - hash containing car attributes:
    - color - [String] - one of next colors: black, green, blue
    - model - [String]
    - price - [Integer] - should be positive

All parameters required.

Respond statuses:
- 201 - resource created successful
- 422 - wrong attributes passed


### Delete car

`DELETE /cars/:id`

Respond statuses:
- 201 - resource created successful
- 404 - car not found
- 422 - wrong attributes passed

### List available cars

`GET /cars`

Parameters:
- color - [String]
- model - [String]
- min_price - [Integer]
- max_price - [Integer]
- start_at - [Date] - start of expected rent
- end_at - [Date] - end of expected rent

Respond statuses:
- 201 - resource created successful
- 422 - wrong attributes passed


## Rent endpoints

### Create rent

`POST /rents`

Parameters:
- rent - [Hash] - hash containing rent attributes:
    - car_id - [Integer]
    - start_at - [Date] - start of expected rent
    - end_at - [Date] - end of expected rent

Respond statuses:
- 201 - resource created successful
- 404 - car not found
- 422 - wrong attributes passed
- 409 - car already rented

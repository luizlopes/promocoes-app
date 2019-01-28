# Coupons System


## About

This project consists in a web application and an API.

The Coupons web app allows the marketing team to create, approve and activate promotions, and also to generate/export coupons tied to the desired promotions.

As for the API, it consumes the Products data during the promotion creation process, and responds to requests on coupons validity, returning the discount 
associated with them or an appropriate error message with an HTTP status.

## Setup


### Requirements

Docker 1.13, found [here](https://docs.docker.com/engine/installation/)

Docker-compose 1.11, found [here](https://docs.docker.com/compose/install/)

*The system is coded in Ruby 2.3.3 and Rails 5.0.1, which are set up automatically for you upon running the docker container.*

### Step by step

    git clone git@qsd.campuscode.com.br:projeto_final/cupom.git
    cd cupom
    docker-compose build
    docker-compose run web bin/setup
    docker-compose up

## Coupons API usage

### Coupon validity

To assure the coupon given is valid, the system needs that `coupon's code`, the `order number` (generate during the checkout process) and the `product key` (identifies the product chosen by the end consumer). 

The following endpoint was designed to achieve that purpose:
 
    PATCH http://vps1548.publiccloud.com.br/api/v1/coupons/coupon_code/burn
    
*Please note that a PUT request is also valid, and that the body of the request must contain the order number and the product key.*   

#### Responses

The response for a correct request is the discount as a percentage, and will look like this:
    
    Status: 200 OK
    
    { "discount" : "40.0" }
    
In case the coupon does not exist:

    Status: 404 Not Found
    
    "Coupon does not exist"
    
If the coupon has already been used:
    
    Status: 412 Precondition Failed
    
    "Coupon has already been used"
    
Granted that the required parameters are not found in the body of the request:    
    
    Status: 412 Precondition Failed
    
    "Order number and Product Key are necessary to consume a coupon"
    
Or, if the promotion related to that coupon is expired:
    
    Status: 412 Precondition Failed
    
    "Coupon's promotion is expired"

And finally, provided the coupon exists, but its promotion is not tied to the correct product chosen by the end user:

    Status: 412 Precondition Failed
    
    "Coupon does not relate to the product given"
    
    
### Coupon information

Fetching some more information from the coupon, other than just returning if it is valid or not, might come in handy depending on the situation.
So, if you want to display it in the checkout process, which serves as a sort of confirmation for the end user (what product/promotion is the coupon tied to), for instance, 
you should use the following endpoint:

    GET http://vps1548.publiccloud.com.br/api/v1/coupons/coupon_code

*Please note that this is a GET request and, therefore, does not require any information in its body.*    

#### Responses

This is the response, whenever it receives an existing coupon:

    Status: 200 OK
    
    {
        "status": "available",
        "discount": "80.0",
        "promotion_name": "Promotion Name"
    }
    
*Please note that this will return a coupon even if it is invalid.*    
*If the coupon does not exist, the response will be the same as shown in the 'Coupon Validity' section*    

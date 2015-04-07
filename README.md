CurrencyTracker
===============

Heroku:
-------
For connection we should provide Api Key.

curl -H "X-Api-Key: f651dde722b0e21c291843b4f2f63d16" http://currency-tacker-v2.herokuapp.com/api/v1/currencies/ZWD

curl -H "X-Api-Key: f651dde722b0e21c291843b4f2f63d16" 

http://currency-tacker-v2.herokuapp.com/api/v1/countries/country_list/18

Same for local instance.

http://localhost:3000/api/v1/countries/country_list/1802

API:
----
```Ruby
  namespace :api, defaults: {format: 'json'} do
  
    namespace :v1 do
    
      resources :countries, :except => [:new, :edit] do 
      
        match 'country_list/:max_weight', :via => [:get], :on => :collection
        
      end
      
      resources :currencies, :except => [:new, :edit]
      
    end
    
  end
```

CurrencyTrackerV2
=================

CurrencyTrackerV2 allows you to track your personal collection of world currencies, pick best routes, use secure connection and to enjoy SOA app.

Setup
-----

Seed the database with currencies, countries and user by running:

```bash
rake db:seed
```

Testing
-------

Run all test with:

```bash
rspec
```

Features
--------

* Multi-tenant app
* Converted to SOA
* API endpoint that takes a value for available weight capacity and returns a list of unvisited countries that will maximize the “value” of the collected currencies

New Feature explanation:
------------------------

Using Linear Programming for this task, method Gomory (Cutting-plane method).

For most of data sets it's average time is polynomial, which is good for this task.

For the fastest result i used C library <<Ruby GNU Linear Programming Kit>>.

references:

http://en.wikipedia.org/wiki/Linear_programming

http://en.wikipedia.org/wiki/Cutting-plane_method

http://en.wikipedia.org/wiki/GNU_Linear_Programming_Kit

https://www.google.com/?q=Cutting-plane+method+polynomial+time

Example:
--------

Country Currency Weight Value

Country A Currency A 5 25

Country B Currency B 4 50

Country C Currency C 3 10

Country D Currency D 10 110

steps:

1. Calculate value / weight for each currency.
ex. 5 12.5 3.(3) 11

2. Creat function which we need to Maximize.
ex. 5*A + 12.5*B + 3.(3)*C + 11 * D = MAX (A,B..D are amount of our currency, coefficients are value / weight for each currency)

3. Create restriction for our function.
ex. 5*A + 4*B + 3*C + 10 * D = max_weight (A,B..D are amount of our currency, coefficients are currency weights)

4. We have a standard maximization problem from Linear Programming.

5. Use the algorithm library... Explaining alg requires some complex Math. In short it can be described as moving from a basic feasible solution to an adjacent basic feasible solution through a graph of solutions, so worst case scenario is O(2^n), n - number of inequality constraints in m non-negative variables which can go up to 2^n - 1 pivots. However in general we can find the best solution quite fast, even better if solution is none-achievable in sane time then we would get the closest values that we can get in polynomial time.

TODO
----
* Create more tests (unit, controller).
* Provide more test data.
* API versioning can be improved. We could provide version via Headers or use specific gem for better versioning.
* Mor API methods.
* Weight precision can be slightly improved by using BigDecimal.
* Error handling can be improved

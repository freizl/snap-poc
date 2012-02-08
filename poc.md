# TODO
  - [ ] bootstrap and dynamic nav splices
  - [ ] snaplet-mongoDB
  - [X] checkout (save order form)
  - [ ] testing data prepare (json?)
  - [ ] persiste change to mongodb
  - [ ] Minify JS and CSS
  - [ ] src dir structure refactoring??

# Questions
### DIR Structure

design every sub site as snaplet ? check existing snaplets(mongodb)
or following  staticPages, is it a snaplet as well?

src (Types / Handler / Application )

  - Maybe Internal
  - Home (include about, help, etc..)
  - Products
  - Shopping cart
  - Checkout
  - Main.hs
  - Application.hs

# Some thinkings
### BACKLOG
  - ADMIN-Add new product
  - ADMIN-Delete/Update a product
  - ADMIN-List all product
  - List products at home page
  - View detail of a product
  - Check out a product without login
  - (Optional?)User be able to update ordering status when received

### DATA MODEL
  - Product {ID, NAME, PRICE}
  - Order {ID, NAME, PRODUCT-ID, STATUS}
  - ??more
  - ??Relation Query in MongoDB

### MORE THAN A POC
  - payment service
  - shopping cart
  - delivery method?
  - App deployment/upgrade
  - localization

# OTHER OPTION
  - Scala + Lift ??

# TODO
  #. checkout (save order form)
  #. testing data prepare (json?)
  #. persiste change to mongodb
  #. Minify JS and CSS
  #. src dir structure refactoring??

# Questions
#. StaticPages src
  HasHeist
  SnapletInit
  what mean by `addRoutes [ ("", serveStaticPages) ]` since the router url is empty
    -- serveStaticPages do some route matching on its own

#. snap-site src 
  makeSnaplet
  nestSnaplet
  ifTop
  bindSplices
  mapSplices

#. Heist
  heistLocal
  <static> tag

# DIR Structure

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
  - User be able to update ordering status when received

### DATA MODEL
  - Product {ID, NAME, PRICE}
  - Order {ID, NAME, PRODUCT-ID, STATUS}
  - ??more
  - Relation Query in MongoDB

### MORE THAN A POC
  - payment service
  - shopping cart
  - delivery method?
  - App deployment/upgrade
  - localization

# OTHER OPTION
  - Scala + Lift

# MISC
  - [babymall](https://www.babymallonline.com/)
  - [mbaobao](http://www.mbaobao.com/)

# DONE

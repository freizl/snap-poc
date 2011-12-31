# TODO
  # display detail
  # checkout
  # testing data (json?)
  # persiste change to mongodb
  # src dir structure refactoring?
  # Minify JS and CSS

# Questions
2. StaticPages src
  HasHeist
  SnapletInit
  what mean by `addRoutes [ ("", serveStaticPages) ]` since the router url is empty
3. snap-site src 
  makeSnaplet :: Text -> Text -> Maybe (IO FilePath) -> Initializer b v v -> SnapletInit b v
  nestSnaplet :: ByteString -> (Lens v (Snaplet v1)) -> SnapletInit b v1 -> Initializer b v (Snaplet v1)
  addRoutes   :: [(ByteString, Handler b v ())] -> Initializer b v ()
  ifTop
  bindSplices
  mapSplices

4. Heist
  heistLocal
  <static> tag



# dir structure

design every sub site as snaplet ? check existing snaplets(mongodb)
or following  staticPages, is it a snaplet as well?

src (Types / Handler / Application )

  - Internal
  - Home
  - Products
  - About
  - Contact
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

### MORE THAN A POC
  - payment service
  - delivery method?
  - App deployment/upgrade


# OTHER OPTION
  - Scala + Lift

# MISC
  - [babymall](https://www.babymallonline.com/)
  - [mbaobao](http://www.mbaobao.com/)

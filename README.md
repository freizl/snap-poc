# TODO
  - [X] pagedown Markdown intergration.
    + did some fix to digestive-functor-heist
  - [ ] Admin snaplet like admin site of Django??
    + easy for admin models
  - [X] digestive-functors form
    + only work with snap-8.*
  - [ ] email registration
  - [X] bootstrap and dynamic nav splices
  - [X] snaplet-mongoDB
  - [X] checkout (save order form)
  - [ ] testing data prepare (json?)
  - [ ] persiste change to mongodb
  - [ ] Minify JS and CSS
  - [X] src dir structure refactoring??
  - [ ] localization
  - [ ] Understand Snaplet

# Issues / Concerns
  - [ ] openid / oauth
    + need https client. anything in snap but http-conduit ?


# notes...

## Heist
  - The <content/> tag is always bound to the complete contents of the calling apply tag. 
    However, any bind tags inside the apply will disappear.
  - [ ] snap-website: custom splices, dynamic template reloading, and content caching
  - With Heist you can define your own domain-specific HTML and XML tags implemented 
    with Haskell and use them in your templates.
  - [X] play getParamNode
  - [ ] understand functor instance of (TemplateMonad m) 
  - heistLocal
  - <static> tag

~~~~~{.haskell}
> <speech author="Shakespeare">
>   To sleep, perchance to dream.
> </speech>
~~~~~

## Snaplet

### work with state
  - `Handler b v` has a `MonadState v` instance
  - MonadReader
  - MonadIO, [Functional Programming with Overloading and Higher-Order Polymorphism, Mark P Jones](http://web.cecs.pdx.edu/~mpj/pubs/springschool95.pdf) 


## StaticPages src
  - HasHeist
  - SnapletInit
  - what mean by `addRoutes [ ("", serveStaticPages) ]` since the router url is empty
    - serveStaticPages do some route matching on its own
    - see more at snaplet-tutorial : nestSnaplet, talking about how to nested a snaplet

## snap-site src 
  - `makeSnaplet :: Text -> Text -> Maybe (IO FilePath) -> Initializer b v v -> SnapletInit b v`
  - `nestSnaplet :: ByteString -> (Lens v (Snaplet v1)) -> SnapletInit b v1 -> Initializer b v (Snaplet v1)`
  - `addRoutes   :: [(ByteString, Handler b v ())] -> Initializer b v ()`
  - ifTop
  - bindSplices
  - mapSplices

## Miscs
1)
All Monad extensions are Monad, which means they probably live in `do` context as well.
Hence, with the type definition of the function, it is possible to reason about type of some general functions, e.g. `get`

2)
fn :: `Initializer App App App`
and  `Initializer App App` is Monad
when doing glue with do, only last one must have type `Initializer App App App` and others are `Initializer App App a`
In other words, MonadState/MonadTransform is a Monad as well.

3)
getRequest in Handler
`modifyResponse $ setContentType "application/json"`


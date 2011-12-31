dive into snap

# notes...

## Heist
  - The <content/> tag is always bound to the complete contents of the calling apply tag. 
    However, any bind tags inside the apply will disappear.
  - [ ] snap-website: custom splices, dynamic template reloading, and content caching
  - With Heist you can define your own domain-specific HTML and XML tags implemented 
    with Haskell and use them in your templates.
  - [X] play getParamNode
    > <speech author="Shakespeare">
    >   To sleep, perchance to dream.
    > </speech>
  - [ ] understand functor instance of (TemplateMonad m) 
## Snaplet

### work with state
  - Handler b v has a __MonadState__ v instance
  - MonadReader
  - MonadIO, [Functional Programming with Overloading and Higher-Order Polymorphism, Mark P Jones](http://web.cecs.pdx.edu/~mpj/) 

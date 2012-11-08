## Experts MVP
&copy; 2012 Ryan Graham. All rights reserved.

This is what I wanted to do after a first wild stab, and then a proper MVP.

The demo us running at [on-deck.herokuapp.com](http://on-deck.herokuapp.com/).

### Features & Limitations

I've implemented the skill tagging concept mentioned in `experts-mvp`
([source](https://github.com/rmg/experts-mvp),
[demo](http://experts-mvp.herokuapp.com)).

This version supports only Google OAuth 2.0 for account creation
and authentication.

Additionally, I implemented a poor-man's multi-tenancy by grouping users based
on the domain of the email address they register with. If your company uses Google
Apps on your domain, this will work particularly well. Not surprisingly, a side 
effect of this simplistic approach is all gmail.com users are grouped together.
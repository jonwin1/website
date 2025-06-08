---
cover:
  alt: ""
  caption: ""
  image: ""
date: "2024-05-03T16:27:52+02:00"
draft: false
title: This Website
---

I created this website to have a single place to document all my projects and
share them. It will also serve as a kind of portfolio that shows what things I have
worked on and learned.

## This Website

This website was build with [Hugo](https://gohugo.io/) which is a open-source 
static site generator, Hugo allows you to generate posts like this one from 
markdown files. I use the [PaperMod](https://github.com/adityatelange/hugo-PaperMod)
theme for my site, it is a clean and simple theme with many useful features.
I have made one simple modification to the theme which is to add a last modified
date like described by [Jackson Lucky](https://www.jacksonlucky.net/posts/use-lastmod-with-papermod/).
The date will only appear if the post has been modified since it was posted and
it will automatically update using the files Git history to know when the post 
was last modified.

## Create Your Own Website

You could either clone my [repo](https://github.com/jonwin1/website) and modify
it to fit your needs or follow this [guide](https://gohugo.io/getting-started/quick-start/)
to create your own.

### Using My Repo

To use my repo as the base of your own website do the following:

```zsh
git clone https://github.com/jonwin1/website
cd website
git submodule update --init --recursive # Clone submodules (the theme)
hugo server -D # Start development server with drafts
```

The pages are located in the `/content/` directory with the exception of the home
page which is configured in `config.yml` *(I have chosen to change the hugo.toml
to config.yml since many tutorials and examples I looked at used yaml and 
recommended it as easier to read)*. Once the server is started you can open the
website at the address shown in the therminal, usually [localhost:1313](http://localhost:1313/).

If you intend to use my repo for your own website I recommend removing all
files from `/content/posts/` and creating your own posts . Lastly modify
`config.yml` to use your own url, title, homepage content, logo, etc.

For more info on how to create posts and more view the [Hugo documentation](https://gohugo.io/getting-started/),
some other good sources of information are the [PaperMod wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)
and this [post](https://jessewei.dev/blog/2023/papermod/#conclusion) by Jesse Wei.

### Deploying

I have used Cloudflare Pages to deploy my website and I would recommend it to 
others since it is very easy and free. Cloudflare has a good [guide](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/)
on how to deploy a Hugo site using Cloudflare Pages, this guide also contain
some instructions on how to create a hugo site. 

Hosting your site this way is very simple because once it is configured you
only need to push changes to your git repo and then the website will be updated
with the changes automatically.

If you own a domain name you can configure your website to use this domain instead
of the `*.pages.dev` address provided by Cloudflare, to to this follow this 
[guide](https://developers.cloudflare.com/pages/configuration/custom-domains/).
If your domain is already managed by Cloudflare this is very easy and Cloudflare
takes care of almost everything, otherwise you might have to add some DNS records
manually.

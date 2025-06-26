# Run app in R with shiny
shiny::runApp()

# Export app with shinylive
shinylive::export(appdir = ".", destdir = "docs", site_url = "https://martin-e-k.github.io/shinylive_test/")

# Run static server from docs locally
httpuv::runStaticServer("docs")

app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(dataset = "pressure")
app$setInputs(obs = 1000)
app$snapshot()
app$setInputs(dataset = "rock")
app$setInputs(obs = 1)
app$snapshot()
app$setInputs(obs = 1000)
app$setInputs(dataset = "pressure")
app$snapshot()

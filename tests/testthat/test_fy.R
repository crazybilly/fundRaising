context("fiscal year is a year")

test_that("fy produces a year", {

  a <- '2017-08-01'
  b <- 2018

  expect_equal(fy(a),b)

})

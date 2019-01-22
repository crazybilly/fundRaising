context("fiscal quarters function produces expected values")

test_that("fy quarters produces three columns with the expected values", {

  a <- tibble::tribble(
    ~last_gift_date,
    '2016-11-10',
    '2016-05-27',
    '2002-09-11',
    '2017-01-03'
  )
  b <- tibble::tribble(
    ~last_gift_date,~gift_month,~fiscal_month,~fiscal_quarter,
    '2016-11-10',11,5,2,
    '2016-05-27',5,11,4,
    '2002-09-11',9,3,1,
    '2017-01-03',1,7,3
  )

  expect_equal(fy_quarters(a,last_gift_date),b)

})

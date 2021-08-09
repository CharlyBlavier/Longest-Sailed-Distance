library(testthat)

context("testing data import")

test_that("Correct Data Import", {
  
  expect_true(length(shipMovements) == 20)
  expect_true(nrow(shipMovements)>0)
  
})

test_that("Correct Ship types Info", {
  
  expect_true(length(ship_types) == 2)
  expect_true(nrow(ship_types)>0)
  
})

test_that("Correct Ship Info", {
  
  expect_true(length(ships) == 3)
  expect_true(nrow(ships)>0)
  
})
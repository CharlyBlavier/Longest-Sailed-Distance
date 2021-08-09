library(testthat)

context("testing leaflet elements")

test_that("Correct Popups String", {
  popupString<- popups_time_and_speed(shipMovements[10000,])
  
  expect_true(is.character(popupString))
  expect_true(!is.na(popupString))
})
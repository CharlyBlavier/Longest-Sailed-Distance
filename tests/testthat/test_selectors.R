library(testthat)

context("testing selectors")

test_that("Correct Ships of type 7", {
  
  shiptype <- 7
  
  shipstype<- ships_of_type(shiptype)
  
  expect_true(length(shipstype) == 2)
  expect_true(nrow(shipstype) > 0)

})

test_that("Correct Dropdown for Ships of type 7", {
  
  shiptype <- 7
  
  shipstype<- ships_of_type(shiptype)
  
  shipdropdown<-dropdown_selected_ship(shipstype)
  
  expect_type(shipdropdown, "list")
})
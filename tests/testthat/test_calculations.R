library(testthat)

context("testing calculations")

test_that("Correct Longest Distance Dataframe", {

  movement <- longestSailedDistance(732836)
  
  expect_true(length(movement) == 21)
  expect_true(movement[[1,"Distance"]]>movement[[2,"Distance"]])
  expect_true(nrow(movement) == 2)
})

test_that("Correct LATITUD Center of 2 coordinates", {
  lat1 <- sample(-90:90, 1)
  lat2 <- sample(-90:90, 1)  
  
  centerLAT <- zoom_lat(lat1,lat2)
  
  expect_true(is.numeric(centerLAT))
  expect_true(centerLAT <= 90 & centerLAT >= -90)
})

test_that("Correct LONGITUD Center of 2 coordinates", {
  lon1 <- sample(-180:180, 1)
  lon2 <- sample(-180:180, 1)  
  
  centerLON <- zoom_lon(lon1,lon2)
  
  expect_true(is.numeric(centerLON))
  expect_true(centerLON <= 180 & centerLON >= -180)
})

test_that("Correct Zoom level for 2 coordinates", {
  lon1 <- sample(-180:180, 1)
  lat1 <- sample(-90:90, 1)
  lon2 <- sample(-180:180, 1)  
  lat2 <- sample(-90:90, 1)
  
  centerZOOM <- zoom_level(lat1,lat2,lon1,lon2)
  
  expect_true(is.numeric(centerZOOM))
  expect_true(centerZOOM >= 0 & centerZOOM <=18)
})

test_that("Correct Flyto parameter for the zoom level for 2 coordinates", {
  lon1 <- sample(-180:180, 1)
  lat1 <- sample(-90:90, 1)
  lon2 <- sample(-180:180, 1)  
  lat2 <- sample(-90:90, 1)
  
  flytoZOOM <- zoom_flyto(lat1,lat2,lon1,lon2)
  
  expect_true(length(flytoZOOM) == 3)
})


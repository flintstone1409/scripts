package main

import (
	"fmt"
	"math"
	"sync"
)

func main() {
	printerThreads := 8

	var wgPrimeChecker sync.WaitGroup
	var wgPrinter sync.WaitGroup
	c := make(chan int64)

	for i := 0; i < printerThreads; i++ {
		wgPrinter.Add(1)
		go printChannel(c, &wgPrinter)
	}

	for i := int64(2); i < 10000000; i++ {
		wgPrimeChecker.Add(1)
		go checkPrime(i, &wgPrimeChecker, c)
	}

	wgPrimeChecker.Wait()
	for i := 0; i < printerThreads; i++ {
		c <- 0
	}
	wgPrinter.Wait()
}

func checkPrime(num int64, wg *sync.WaitGroup, c chan int64) {
	defer wg.Done()
	prime := true

	for i := int64(2); i < int64(math.Sqrt(float64(num))); i++ {
		if (num % i) == 0 {
			prime = false
		}
	}

	if prime {
		c <- num
	}
}

func printChannel(c chan int64, wg *sync.WaitGroup) {
	defer wg.Done()

	for true {
		x := <-c
		if x == 0 {
			break
		}
		fmt.Println(x)
	}
}

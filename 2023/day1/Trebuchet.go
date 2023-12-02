package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

var numMap = map[string]int{
	"one":   1,
	"two":   2,
	"three": 3,
	"four":  4,
	"five":  5,
	"six":   6,
	"seven": 7,
	"eight": 8,
	"nine":  9,
}

func convertWordToNumber(word string) int {
	return numMap[strings.ToLower(word)]
}

func main() {
	if len(os.Args) < 2 {
		os.Exit(1)
	}

	file, _ := os.Open(os.Args[1])
	defer file.Close()

	scanner := bufio.NewScanner(file)
	res := 0

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		matches := regexp.MustCompile(`(\d|one|two|three|four|five|six|seven|eight|nine)`).FindAllString(line, -1)

		if len(matches) > 0 {
			firstNumber, err := strconv.Atoi(matches[0])
			if err != nil {
				firstNumber = convertWordToNumber(matches[0])
			}

			lastNumber, err := strconv.Atoi(matches[len(matches)-1])
			if err != nil {
				lastNumber = convertWordToNumber(matches[len(matches)-1])
			}

			concatenatedValue := strconv.Itoa(firstNumber) + strconv.Itoa(lastNumber)
			concatenatedNumber, _ := strconv.Atoi(concatenatedValue)
			res += concatenatedNumber
		}
	}

	fmt.Printf("%d\n", res)
}

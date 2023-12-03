package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func part1(lines []string) {
	limits := map[string]int{
		"red":   12,
		"green": 13,
		"blue":  14,
	}
	sumOfIDs := 0

	for _, line := range lines {
		if match := regexp.MustCompile(`^Game (\d+): (.+)$`).FindStringSubmatch(line); match != nil {
			gameNumber, gameData := match[1], match[2]

			possible := true

			for _, submatch := range regexp.MustCompile(`(\d+)\s*(\w+)`).FindAllStringSubmatch(gameData, -1) {
				number, color := submatch[1], submatch[2]
				if n, err := strconv.Atoi(number); err == nil {
					if n > limits[color] {
						possible = false
						break
					}
				}
			}

			if possible {
				if n, err := strconv.Atoi(gameNumber); err == nil {
					sumOfIDs += n
				}
			}
		}
	}

	fmt.Printf("Part 1. Sum of IDs of possible games: %d\n", sumOfIDs)
}

func part2(lines []string) {
	sumOfIDs := 0

	for _, line := range lines {
		if match := regexp.MustCompile(`^Game \d+: (.+)$`).FindStringSubmatch(line); match != nil {
			gameData := match[1]

			colorCount := make(map[string]int)
			for _, submatch := range regexp.MustCompile(`(\d+)\s*(\w+)`).FindAllStringSubmatch(gameData, -1) {
				number, color := submatch[1], submatch[2]
				if n, err := strconv.Atoi(number); err == nil {
					if n > colorCount[color] {
						colorCount[color] = n
					}
				}
			}

			multipl := 1
			for _, value := range colorCount {
				multipl *= value
			}

			sumOfIDs += multipl
		}
	}

	fmt.Printf("Part 2. Sum: %d\n", sumOfIDs)
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run CubeConundrum.go input_file.txt")
		os.Exit(1)
	}

	file, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Printf("Error opening file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	part1(lines)
	part2(lines)
}

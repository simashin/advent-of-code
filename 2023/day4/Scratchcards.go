package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func calcMatches(card string) int {
	re := regexp.MustCompile(`Card\s+(\d+):(.+)\|(.+)`)
	match := re.FindStringSubmatch(card)
	if len(match) > 0 {
		winningNumbers, myNumbers := match[2], match[3]
		winningNumbersSet := make(map[int]struct{})
		myNumbersSet := make(map[int]struct{})

		for _, numStr := range strings.Fields(winningNumbers) {
			num, _ := strconv.Atoi(numStr)
			winningNumbersSet[num] = struct{}{}
		}

		for _, numStr := range strings.Fields(myNumbers) {
			num, _ := strconv.Atoi(numStr)
			myNumbersSet[num] = struct{}{}
		}

		matchingNumbers := make(map[int]struct{})
		for num := range winningNumbersSet {
			if _, ok := myNumbersSet[num]; ok {
				matchingNumbers[num] = struct{}{}
			}
		}

		return len(matchingNumbers)
	}
	return 0
}

func part1(cards []string) {
	totalPoints := 0
	for _, card := range cards {
		matches := calcMatches(card)
		if matches > 0 {
			totalPoints += 1 << (matches - 1)
		}
	}
	fmt.Printf("Part 1: %d\n", totalPoints)
}

func part2(cards []string) {
	cardsDict := make(map[int]int)
	for _, card := range cards {
		cardNumMatch := regexp.MustCompile(`Card\s+(\d+):`).FindStringSubmatch(card)
		if len(cardNumMatch) > 0 {
			cardNum, _ := strconv.Atoi(cardNumMatch[1])
			cardsDict[cardNum] += 1
			matches := calcMatches(card)
			for i := 1; i <= matches; i++ {
				cardsDict[cardNum+i] += cardsDict[cardNum]
			}
		}
	}

	totalSum := 0
	for _, count := range cardsDict {
		totalSum += count
	}

	fmt.Printf("Part 2: %d\n", totalSum)
}

func main() {
	file, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	var cards []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		cards = append(cards, scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading file:", err)
		return
	}

	part1(cards)
	part2(cards)
}

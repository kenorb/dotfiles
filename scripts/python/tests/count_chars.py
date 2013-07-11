#!/usr/bin/python
# 
# Write a program that analyzes a string and prints the counts of all non-whitespace characters. Output the counts by printing the character followed by its count on a line. Sort the output alphanumerically by the character. 
# 
# For example the input of "this is 1 string of text" should produce the output 
# 
# 1 1 
# e 1 
# f 1 
# g 1 
# h 1 
# i 3 
# n 1 
# o 1 
# r 1 
# s 3 
# t 4 
# x 1 
# 
# Your answer will be evaluated based on: 
# * Working correctly for all possible input text strings 
# * The clarity and simplicity of the solution 
# * The time taken - we would expect this task to take no more than 15-30 minutes 
# 
# NB Please develop your solution in the text area below, but we also encourage you to use your IDE/compiler of choice to test it.

import sys
import string

def count_letters(text):
    letters = {}
    for i in range(0,len(text)):
        letter = text[i]
        if letter.isalnum():
            letters[letter] = letters[letter]+1 if letter in letters else 1
    
    return letters
    
def main():
    args = sys.argv[1:]
    
    if not args:
        print 'usage: text'
        sys.exit(1)
    
    text = args[0]
    chars = count_letters(text)
    for char in sorted(chars):
        print "%s %s" % (char, chars[char])
    
if __name__ == '__main__':
    main()


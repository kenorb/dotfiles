#!/usr/bin/python
# 
# A stopwatch records lap times as strings of the form "MM:SS:HS" where MM = minutes; SS = seconds; and HS = hundredths of a second. 
# Write a function that accepts two lap times and calculates their average, returning the result in the same string format. 
# For example, given the strings "00:02:20" and "00:04:40" the function would return "00:03:30". 
# 
# Your answer will be evaluated based on: 
# * Working correctly for all possible input stopwatch times 
# * The clarity and simplicity of the solution 
# * The time taken - we would expect this task to take no more than 15-30 minutes 
# 
# NB Please develop your solution in the text area below, but we also encourage you to use your IDE/compiler of choice to test it.

import sys
import string

# function that accepts two lap times and calculates their average,
# returning the result in the same string format
# where MM = minutes; SS = seconds; and HS = hundredths of a second. 
def calc_avg(time1, time2):
    (mm1, ss1, hs1) = time1.split(':')
    (mm2, ss2, hs2) = time2.split(':')
    total_hs1 = int(mm1)*60*100 + int(ss1) * 100 + int(hs1)
    total_hs2 = int(mm2)*60*100 + int(ss2) * 100 + int(hs2)
    total_avg = float(total_hs1 + total_hs2) / 2
    avg_mm1 = int(total_avg / (60*100))
    avg_ss1 = int(total_avg / 100)
    avg_hs1 = int(total_avg % 100)
    return "%02d:%02d:%02d" % (avg_mm1, avg_ss1, avg_hs1) 

def main():
    args = sys.argv[1:]
    
    if (len(sys.argv) < 3):
        print 'usage: "MM:SS:HS" "MM:SS:HS"'
        sys.exit(1)
        
    time1 = args[0]
    time2 = args[1]
    print calc_avg(time1, time2)
    
if __name__ == '__main__':
    main()


#include <filesystem>
#include <cassert>
#include "utils.h"

// I cheated on this one because it's just an MD5 test - which in python or whatever is
// just an import away. I couldn't be arsed writing or copying an MD5 hash in C++.

int solve(Path path, int part)
{
    int answer;
    
    return answer;
}

int main(int argc, const char** argv)
{
//    assert(solve("../input/day3", 1) == 2081);
//    assert(solve("../input/day3", 2) == 2341);

    std::cout << "problem 1:" << solve("../input/day4", 1) << std::endl;
//    std::cout << "problem 2:" << solve("../input/day3", 2) << std::endl;

    return 0;
}

/* part 1

To do this, he needs to find MD5 hashes which, in hexadecimal, start with at least five zeroes. 
The input to the MD5 hash is some secret key (your puzzle input, given below) followed by a number in decimal. 
To mine AdventCoins, you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.

For example:

    If your secret key is abcdef, the answer is 609043, because the MD5 hash of abcdef609043 starts with five zeroes (000001dbbfa...), 
    and it is the lowest such number to do so.

    If your secret key is pqrstuv, the lowest number it combines with to make an MD5 hash starting with five zeroes is 1048970; 
    that is, the MD5 hash of pqrstuv1048970 looks like 000006136ef....
*/
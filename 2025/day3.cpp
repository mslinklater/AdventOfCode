#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

int FindMaxDigit(std::string& str, int start, int endGap, int& digitPosOut)
{
    int maxDigit = 0;
    for(int i=start ; i<str.size()-endGap ; ++i)
    {
        int digit = str[i] - '0';
        if(digit > maxDigit)
        {
            maxDigit = digit;
            digitPosOut = i;
        }
    }
    return maxDigit;
}

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;

    StringVector file = GetFileAsLines(filename);

    for(auto line : file)
    {
        assert(line.size() > 1);
        uint64_t number = 0;
        if(part == 1)
        {
            // find largest digit
            int maxDigitPos = -1;
            int maxDigit = FindMaxDigit(line, 0, 1, maxDigitPos);

            int maxDigit2 = 0;
            for(int i=maxDigitPos+1 ; i<line.size() ; ++i)
            {
                int digit = line[i] - '0';
                if(digit > maxDigit2)
                {
                    maxDigit2 = digit;
                }
            }

            number = maxDigit * 10 + maxDigit2;
        }
        else
        {
        }
        answer += number;
    }

    std::cout << "answer: " << answer << std::endl;

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day3test", 1) == 357);
    assert(Solve("../input/day3", 1) == 16946);

    //assert(Solve("../input/day3test", 2) == 3121910778619);
    //assert(Solve("../input/day3", 2) == 30260171216);

    std::cout << "problem 1:" << Solve("../input/day3", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day3", 2) << std::endl;

    return 0;
}
#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

int FindMaxDigit(const std::string& str, int start, int endGap, int& digitPosOut)
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

uint64_t FindMaxNumber(const std::string& str, int numDigits)
{
    uint64_t answer = 0;

    int maxDigitPos = -1;
    for(int i = 0; i < numDigits ; i++)
    {
        answer *= 10;
        answer += FindMaxDigit(str, maxDigitPos+1, numDigits - 1 - i, maxDigitPos);
    }
    return answer;
}

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;

    StringVector file = GetFileAsLines(filename);
    assert(file.size() > 0);

    for(auto line : file)
    {
        assert(line.size() > 1);
        uint64_t number = 0;
        if(part == 1)
        {
            number = FindMaxNumber(line, 2);
        }
        else
        {
            number = FindMaxNumber(line, 12);
        }
        answer += number;
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day3test", 1) == 357);
    assert(Solve("../input/day3", 1) == 16946);

    assert(Solve("../input/day3test", 2) == 3121910778619);
    assert(Solve("../input/day3", 2) == 168627047606506);

    std::cout << "problem 1:" << Solve("../input/day3", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day3", 2) << std::endl;

    return 0;
}

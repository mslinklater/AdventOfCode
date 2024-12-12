#include <cassert>
#include <string>
#include <algorithm>
#include <list>

#include "utils.h"

void AddToMap(std::map<uint64_t, uint64_t>& map, uint64_t num, uint64_t count)
{
    if(!map.contains(num))
        map[num] = count;
    else
        map[num] += count;
}
#if 0
void PrintSize(std::map<uint64_t, uint64_t>& map)
{
    uint64_t answer = 0;
    for(auto num : map)
    {
        answer += num.second;
    }
    std::cout << answer << std::endl;
}
#endif
uint64_t Solve(const std::string& filename, int part, int blinkCount)
{
    uint64_t answer = 0;
    String line = GetFileAsSingleLine(filename);

    ULongVector numbers = ULongVecFromStringVec(SplitStringByChar(line, ' '));

    std::map<uint64_t, uint64_t> numberMap;
    for(uint64_t num : numbers)
    {
        AddToMap(numberMap, num, 1);
    }

    for(int iter = 0; iter < blinkCount ; ++iter)
    {
        std::map<uint64_t, uint64_t> newNumberMap;

        for(auto num : numberMap)
        {
            if(num.first == 0)
            {
                AddToMap(newNumberMap, 1, num.second);
            }
            else if(std::to_string(num.first).size() % 2 == 0)
            {
                String numString = std::to_string(num.first);
                uint64_t firstNum = std::stoll(numString.substr(0, numString.size()/2));
                uint64_t secondNum = std::stoll(numString.substr(numString.size()/2, numString.size()/2));
                AddToMap(newNumberMap, firstNum, num.second);
                AddToMap(newNumberMap, secondNum, num.second);
            }
            else
            {
                AddToMap(newNumberMap, num.first * 2024, num.second);
            }
        }
        numberMap = newNumberMap;
    }

    for(auto num : numberMap)
    {
        answer += num.second;
    }
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day11test", 1, 6) == 22);    // 6 times
    assert(Solve("../input/day11test", 1, 25) == 55312);    // 25 times

    assert(Solve("../input/day11", 1, 25) == 216996);
    assert(Solve("../input/day11", 1, 75) == 257335372288947);

    std::cout << "problem 1:" << Solve("../input/day11", 1, 25) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day11", 1, 75) << std::endl;

    return 0;
}

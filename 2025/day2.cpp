#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;

    StringVector file = GetFileAsLines(filename);
    StringVector ranges = SplitStringByChar(file[0], ',');

    for(auto rangeStr : ranges)
    {
        StringVector bounds = SplitStringByChar(rangeStr, '-');
        uint64_t lower = std::stoull(bounds[0]);
        uint64_t upper = std::stoull(bounds[1]);

        for(uint64_t num=lower ; num<=upper ; ++num)
        {
            String numStr = std::to_string(num);
            if(part == 1)
            {
                if(numStr.size() % 2 == 0)
                {
                    uint64_t front = std::stoi(numStr.substr(0, numStr.size()/2));
                    uint64_t back = std::stoi(numStr.substr(numStr.size()/2, numStr.size()/2));
                    if(front == back)
                    {
                        answer += num;
                    }
                }
            }
            else
            {
                for(int numSplits = 2 ; numSplits <= numStr.size() ; ++numSplits)
                {
                    if(numStr.size() % numSplits == 0)
                    {
                        int splitSize = numStr.size() / numSplits;
                        std::vector<uint64_t> splitValues;
                        for(int splitIndex=0 ; splitIndex<numSplits ; ++splitIndex)
                        {
                            String subStr = numStr.substr(splitIndex * splitSize, splitSize);
                            splitValues.push_back(std::stoull(subStr));
                        }
                        uint64_t firstValue = splitValues[0];
                        bool allMatch = true;
                        for(auto v : splitValues)
                        {
                            if(v != firstValue)
                            {
                                allMatch = false;
                                break;
                            }
                        }
                        if(allMatch)
                        {
                            answer += num;
                            break;
                        }
                    }
                }
            }
        }
    }

    std::cout << "answer: " << answer << std::endl;

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day2test", 1) == 1227775554);
    assert(Solve("../input/day2", 1) == 20223751480);

    assert(Solve("../input/day2test", 2) == 4174379265);
    assert(Solve("../input/day2", 2) == 30260171216);

    std::cout << "problem 1:" << Solve("../input/day2", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day2", 2) << std::endl;

    return 0;
}
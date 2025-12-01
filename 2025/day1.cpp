#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

int Solve(const std::string& filename, int part)
{
    int answer = 0;
    int dialPosition = 50;

    std::vector<std::string> file = GetFileAsLines(filename);
    for(auto line : file)
    {
        // strip first character and parse amount        
        int amount = std::stoi(line.substr(1));
//        int loopCount = (amount / 100) + 1;
//        amount = amount % 100;

        if(line[0] == 'L')
        {
            amount = -amount;
        }

        if(part == 1)
        {
            dialPosition += amount;
            dialPosition = (dialPosition + 100) % 100;

            if(dialPosition == 0)
            {
                answer += 1;
            }
        }
        else
        {
            if(amount > 0)
            {
                while(amount > 0)
                {
                    dialPosition += 1;
                    dialPosition = dialPosition % 100;
                    if(dialPosition == 0)
                    {
                        answer += 1;
                    }
                    amount--;
                }
            }
            if(amount < 0)
            {
                while(amount < 0)
                {
                    dialPosition -= 1;
                    dialPosition = (dialPosition + 100) % 100;
                    if(dialPosition == 0)
                    {
                        answer += 1;
                    }
                    amount++;
                }
            }
        }
    }
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day1test", 1) == 3);
    assert(Solve("../input/day1", 1) == 1078);

    assert(Solve("../input/day1test", 2) == 6);
    assert(Solve("../input/day1", 2) == 6412);

    std::cout << "problem 1:" << Solve("../input/day1", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day1", 2) << std::endl;

    return 0;
}
#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Calculation
{
    std::vector<uint64_t> numbers;
    char operation;
};

std::vector<Calculation> calculations;

void ParseFile(const std::string& filename, int calcSize)
{
    calculations.clear();
    StringVector lines = GetFileAsLines(filename);
    int lineNumber = 0;
    for(const String& line : lines)
    {
        if(lineNumber < calcSize)
        {
            // read numbers
            StringVector parts = SplitStringByChar(line, ' ');
            for(const String& p : parts)
            {
                if(lineNumber == 0)
                {
                    calculations.push_back(Calculation());
                }
                calculations[lineNumber].numbers.push_back(std::stoll(p));
            }
        }
        else
        {
            // read operation
        }
    }
}

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day6test", 1) == 4277556);
    //assert(Solve("../input/day4", 1) == 1537);

//    assert(Solve("../input/day6test", 2) == 14);
//    assert(Solve("../input/day4", 2) == 8707);

    std::cout << "problem 1:" << Solve("../input/day6", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day5", 2) << std::endl;

    return 0;
}

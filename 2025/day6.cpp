#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Calculation
{
    std::vector<uint64_t> numbers;
    char operation;
    uint64_t Answer() const
    {
        uint64_t result = numbers[0];
        for(size_t i = 1; i < numbers.size(); i++)
        {
            if(operation == '+')
            {
                result += numbers[i];
            }
            else if(operation == '*')
            {
                result *= numbers[i];
            }
        }
        return result;
    }
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
            int calculationIndex = 0;
            for(const String& p : parts)
            {
                if(p.empty()) continue;

                if(lineNumber == 0)
                {
                    calculations.push_back(Calculation());
                }
                calculations[calculationIndex].numbers.push_back(std::stoll(p));
                calculationIndex++;
            }
        }
        else
        {
            int calculationIndex = 0;
            for(char c : line)
            {
                if(c == '+' || c == '*')
                {
                    calculations[calculationIndex].operation = c;
                    calculationIndex++;
                }
            }
            // read operation
        }
        lineNumber++;
    }
}

uint64_t Solve(const std::string& filename, int part, bool isTest)
{
    uint64_t answer = 0;
    ParseFile(filename, isTest ? 3 : 4);
    if(part ==1)
    {
        for(const Calculation& calc : calculations)
        {
            answer += calc.Answer();
        }
    }
    else
    {
    }
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day6test", 1, true) == 4277556);
    assert(Solve("../input/day6", 1, false) == 5316572080628);

    assert(Solve("../input/day6test", 2, true) == 3263827);
//    assert(Solve("../input/day4", 2) == 8707);

    std::cout << "problem 1:" << Solve("../input/day6", 1, false) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day5", 2) << std::endl;

    return 0;
}

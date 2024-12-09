#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Equation
{
    uint64_t answer;
    std::vector<uint64_t> values;
};

void ParseFile(StringVector lines, std::vector<Equation>& equations)
{
    for(auto line : lines)
    {
        Equation eq;
        int colonPos = line.find(":");
        eq.answer = std::stoull(line.substr(0, colonPos));
        std::string values = line.substr(colonPos + 2, -1);
        IntVector intVec = IntVecFromStringVec(SplitStringByChar(values, ' '));
        for(int val : intVec)
            eq.values.push_back((uint64_t)val);
        equations.push_back(eq);
    }
}

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    std::vector<Equation> equations;

    StringVector lines = GetFileAsLines(filename);
    ParseFile(lines, equations);

    int base = 2;

    if(part == 2)
    {
        base = 3;
    }

    for(auto eq : equations)
    {
        bool solvable = false;
        int numOperators = eq.values.size() - 1;
        int numIterations = std::pow(base, numOperators);

        for(int iter = 0; iter < numIterations && !solvable; iter++)
        {
            uint64_t sum = eq.values[0];
            std::vector<int> operatorVector = IntToBaseDigits(iter, base, numOperators);

            for(int op = 0; op < numOperators; op++)
            {
                switch(operatorVector[op])
                {
                    case 0:
                        sum = sum + eq.values[op+1];
                        break;
                    case 1:
                        sum = sum * eq.values[op+1];
                        break;
                    case 2:
                        sum = std::stoll(std::to_string(sum) + std::to_string(eq.values[op+1]));
                        break;
                    default:
                        break;
                }
            }
            if(sum == eq.answer)
            {
                solvable = true;
                answer += sum;
            }
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day7test", 1) == 3749);
    assert(Solve("../input/day7test", 2) == 11387);
    
    assert(Solve("../input/day7", 1) == 4998764814652);
    assert(Solve("../input/day7", 2) == 37598910447546);

    std::cout << "problem 1:" << Solve("../input/day7", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day7", 2) << std::endl;

    return 0;
}
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

    if(part == 1)
    {
        for(auto eq : equations)
        {
            bool solvable = false;
            for(int iter = 0; iter < 1 << eq.values.size() && !solvable; iter++)
            {
                uint64_t sum = eq.values[0];
                for(int op = 0; op < eq.values.size()-1; op++)
                {
                    if(iter & (1 << op))
                    {
                        sum = sum + eq.values[op+1];
                    }
                    else
                    {
                        sum = sum * eq.values[op+1];
                    }
                }
                if(sum == eq.answer)
                {
                    solvable = true;
                    answer += sum;
                }
            }

        }
    }
    else
    {

    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day7test", 1) == 3749);
//    assert(Solve("../input/day6test", 2) == 6);
    
    assert(Solve("../input/day6", 1) == 4998764814652);
//    assert(Solve("../input/day5", 2) == 4681);

    std::cout << "problem 1:" << Solve("../input/day7", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day6", 2) << std::endl;

    return 0;
}
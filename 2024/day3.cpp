#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Instruction
{
    int first;
    int second;
};

void ParseLine(const std::string& line, std::vector<Instruction>& instructionsRef)
{
    int searchpos = 0;
    while(searchpos != std::string::npos)
    {
        searchpos = line.find("mul(", searchpos);

        if(searchpos != std::string::npos)
        {
            searchpos += 4;
            int commapos = line.find_first_not_of("0123456789", searchpos);
            if(line[commapos] == ',')
            {
                int closepos = line.find_first_not_of("0123456789", commapos + 1);
                if(line[closepos] == ')')
                {
                    Instruction inst;
                    inst.first = std::stoi(line.substr(searchpos, searchpos - commapos));
                    inst.second = std::stoi(line.substr(commapos + 1, closepos - commapos - 1));
                    instructionsRef.push_back(inst);
                }
            }
        }
    }
}

int Solve(const std::string& filename, int part)
{
    int answer = 0;
    std::vector<std::string> file = GetFileAsLines(filename);
    std::vector<Instruction> instructions;

    for(auto line : file)
    {
        ParseLine(line, instructions);
    }

    for(auto ins : instructions)
    {
        answer += ins.first * ins.second;
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day3test", 1) == 161);
    
    assert(Solve("../input/day3", 1) == 167090022);
//    assert(Solve("../input/day3", 2) == 544);

    std::cout << "problem 1:" << Solve("../input/day3", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day3", 2) << std::endl;

    return 0;
}
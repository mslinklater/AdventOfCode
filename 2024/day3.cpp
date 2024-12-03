#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Instruction
{
    int first;
    int second;
};

struct Command
{
    int pos;
    bool isEnable;
};

void ParseCommands(const std::string& line, std::vector<Command>& commands)
{
    int pos = 0;
    Command c;
    c.pos = 0;
    c.isEnable = true;
    commands.push_back(c);
    bool lastEnable = true;
    while(pos != std::string::npos)
    {
        uint dopos = line.find("do()", pos + 1);
        uint dontpos = line.find("don't()", pos + 1);
        bool thisEnable = dopos < dontpos;
        pos = std::min(dopos, dontpos);
        if(pos != std::string::npos)
        {
            if(thisEnable != lastEnable)
            {
                c.pos = pos;
                c.isEnable = thisEnable;
                commands.push_back(c);
            }
            lastEnable = thisEnable;
        }
    }
}

void ParseLine(const std::string& line, std::vector<Instruction>& instructionsRef, std::vector<Command>* pCommands)
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
                    bool add = true;

                    if(pCommands)
                    {
                        for(int i=0 ; i<pCommands->size() - 1 ; i++)
                        {
                            if(((*pCommands)[i].pos < searchpos) && ((*pCommands)[i+1].pos > searchpos))
                            {
                                add = (*pCommands)[i].isEnable;
                            }
                        }
                    }

                    if(add) 
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
}

int Solve(const std::string& filename, int part)
{
    int answer = 0;
    std::vector<std::string> file = GetFileAsLines(filename);
    std::vector<Instruction> instructions;
    std::vector<Command> commands;

    for(auto line : file)
    {
        commands.clear();
        ParseCommands(line, commands);

        if(part == 1)
            ParseLine(line, instructions, nullptr);
        else
            ParseLine(line, instructions, &commands);
    }

    // sum of products
    for(auto ins : instructions)
    {
        answer += ins.first * ins.second;
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day3test", 1) == 161);
    assert(Solve("../input/day3test", 2) == 48);
    
    assert(Solve("../input/day3", 1) == 167090022);
//    assert(Solve("../input/day3", 2) == 544);

    std::cout << "problem 1:" << Solve("../input/day3", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day3", 2) << std::endl;

    return 0;
}
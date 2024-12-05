#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Rule
{
    int first;
    int second;
};
typedef std::vector<Rule> RuleVector;

bool IsValid(const IntVector& pages, const std::vector<Rule>& rules)
{
    for(auto r : rules)
    {
        auto firstIt = std::find(pages.begin(), pages.end(), r.first);
        int firstPos = firstIt != pages.end() ? std::distance(pages.begin(), firstIt) : -1;

        auto secondIt = std::find(pages.begin(), pages.end(), r.second);
        int secondPos = secondIt != pages.end() ? std::distance(pages.begin(), secondIt) : -1;

        if((firstPos != -1) && (secondPos != -1) && (firstPos > secondPos))
        {
            return false;
        }
    }
    return true;
}

int Solve(const std::string& filename, int part)
{
    int answer = 0;
    RuleVector rules;
    std::vector<IntVector> pagesVec;
    StringVector lines = GetFileAsLines(filename);

    // parse file
    int i=0;
    while(lines[i].size() > 0)
    {
        Rule r;
        r.first = std::stoi(lines[i].substr(0, 2));
        r.second = std::stoi(lines[i].substr(3, 2));
        rules.push_back(r);
        i++;
    }
    i++;
    while(i < lines.size())
    {
        StringVector sv = SplitStringByChar(lines[i], ',');
        IntVector iv;
        for(auto s : sv)
        {
            iv.push_back(std::stoi(s));
        }
        pagesVec.push_back(iv);
        i++;
    }

    // Now do the calcs
    for(auto pages : pagesVec)
    {
        bool valid = IsValid(pages, rules);

        if(part == 1)
        {
            if (valid)
            {
                answer += pages[pages.size() / 2];
            }
        }
        else
        {
            if(!valid)
            {
                while(!IsValid(pages, rules))
                {
                    for(auto r : rules)
                    {
                        auto firstIt = std::find(pages.begin(), pages.end(), r.first);
                        int firstPos = firstIt != pages.end() ? std::distance(pages.begin(), firstIt) : -1;

                        auto secondIt = std::find(pages.begin(), pages.end(), r.second);
                        int secondPos = secondIt != pages.end() ? std::distance(pages.begin(), secondIt) : -1;

                        if((firstPos != -1) && (secondPos != -1) && (firstPos > secondPos))
                        {
                            std::swap(pages[firstPos], pages[secondPos]);
                        }
                    }

                }
                answer += pages[pages.size() / 2];
            }
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day5test", 1) == 143);
    assert(Solve("../input/day5test", 2) == 123);
    
    assert(Solve("../input/day5", 1) == 5091);
    assert(Solve("../input/day5", 2) == 4681);

    std::cout << "problem 1:" << Solve("../input/day5", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day5", 2) << std::endl;

    return 0;
}
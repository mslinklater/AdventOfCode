#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

int solve(const std::string& filename, int part)
{
    int answer = 0;
    std::vector<int> list1;
    std::vector<int> list2;

    std::vector<std::string> file = GetFileAsLines(filename);
    for(auto line : file)
    {
        int pos = line.find("   ");   // the gap between the numbers
        list1.push_back(std::stoi(line.substr(0, pos)));
        list2.push_back(std::stoi(line.substr(pos+3)));
    }
    std::sort(list1.begin(), list1.end());
    std::sort(list2.begin(), list2.end());

    if(part == 1)
    {
        for(int i=0; i<list1.size() ; ++i)
        {
            answer += std::abs(list1[i] - list2[i]);
        }
    }
    else
    {
        for( int num : list1 )
        {
            int count = 0;
            for( int num2 : list2 )
            {
                if(num2 == num)
                    count++;
            }

            answer += num * count;
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(solve("../input/day1test", 1) == 11);
    
    assert(solve("../input/day1", 1) == 1320851);
    assert(solve("../input/day1", 2) == 26859182);

    std::cout << "problem 1:" << solve("../input/day1", 1) << std::endl;
    std::cout << "problem 2:" << solve("../input/day1", 2) << std::endl;

    return 0;
}
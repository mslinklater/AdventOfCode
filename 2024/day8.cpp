#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Cell
{
    char val;
    bool antinode;
};

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    StringVector lines = GetFileAsLines(filename);
    std::vector<std::vector<Cell>> map;

    // populate map
    for(int y=0 ; y<lines.size() ; y++)
    {
        map.push_back(std::vector<Cell>());
        for(int x=0; x<lines[0].size() ; x++)
        {
            Cell c = {lines[y][x], false};
            map[y].push_back(c);
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day8test", 1) == 14);
//    assert(Solve("../input/day6test", 2) == 6);
    
//    assert(Solve("../input/day6", 1) == 4998764814652);
//    assert(Solve("../input/day5", 2) == 4681);

    std::cout << "problem 1:" << Solve("../input/day8", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day6", 2) << std::endl;

    return 0;
}
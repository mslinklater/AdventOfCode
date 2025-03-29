#include <cassert>
#include <string>
#include <algorithm>
#include <list>

#include "utils.h"

struct Plot
{
    Grid2D<char> map;
};

struct InputCell
{
    char c = 0;
    bool plotted = false;
};

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    StringVector lines = GetFileAsLines(filename);
    std::vector<Plot> plots;

    // build map
    Grid2D<InputCell> map(lines[0].size(), lines.size());
    for(int y = 0; y < map.Height(); ++y)
    {
        for(int x = 0 ; x<map.Width() ; ++x)
        {
            InputCell cell;
            cell.c = lines[y][x];
            cell.plotted = false;
        }
    }

    // scan the map and flood-fill for any unplotted call values

    
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day12test", 1) == 1930);
//    assert(Solve("../input/day11test", 1, 25) == 55312);    // 25 times

//    assert(Solve("../input/day11", 1, 25) == 216996);
//    assert(Solve("../input/day11", 1, 75) == 257335372288947);

    std::cout << "problem 1:" << Solve("../input/day12", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day11", 1, 75) << std::endl;

    return 0;
}

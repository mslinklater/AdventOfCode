#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

Grid2D<char> data;

void LoadData(const std::string& filename)
{
    // Placeholder for any data loading if needed in future
    StringVector lines = GetFileAsLines(filename);
    assert(!lines.empty());

    data.Initialize(lines[0].size(), lines.size());
    for(int y=0 ; y<lines.size() ; ++y)
    {
        for(int x=0 ; x<lines[0].size() ; ++x)
        {
            data.Set(x, y, lines[y][x]);
        }
    }
}

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;

    LoadData(filename);

    if(part == 1)
    {

    }
    else
    {

    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day4test", 1) == 13);
    //assert(Solve("../input/day3", 1) == 16946);

    //assert(Solve("../input/day3test", 2) == 3121910778619);
    //assert(Solve("../input/day3", 2) == 168627047606506);

    std::cout << "problem 1:" << Solve("../input/day4", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day4", 2) << std::endl;

    return 0;
}

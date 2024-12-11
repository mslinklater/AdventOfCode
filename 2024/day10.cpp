#include <cassert>
#include <string>
#include <algorithm>
#include <list>

#include "utils.h"

struct Node
{
    int value;
    std::vector<Node> nextNodes;
};

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    StringVector lines = GetFileAsLines(filename);
    int width = lines[0].size();
    int height = lines.size();
    Grid2D<int> map(width, height);
    for(int y=0 ; y<height ; y++)
    {
        for(int x=0; x<height ; x++)
        {
            map.Set(x, y, lines[y][x] - '0');
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day10test1", 1) == 1);
    assert(Solve("../input/day10test2", 1) == 2);
    assert(Solve("../input/day10test3", 1) == 4);
    assert(Solve("../input/day10test4", 1) == 3);
    assert(Solve("../input/day10test", 1) == 36);
//    assert(Solve("../input/day9test", 2) == 2858);

//    assert(Solve("../input/day9", 1) == 6463499258318);
//    assert(Solve("../input/day9", 2) == 6493634986625);

    std::cout << "problem 1:" << Solve("../input/day9", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day9", 2) << std::endl;

    return 0;
}

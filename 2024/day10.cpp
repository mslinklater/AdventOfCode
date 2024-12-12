#include <cassert>
#include <string>
#include <algorithm>
#include <list>

#include "utils.h"

struct Node
{
    Vec2 pos;
    int value;
    std::vector<Node> nextNodes;
};

void BuildNodeGraph(Node& node, const Grid2D<int>& map)
{
    if(node.value == 9) return; // already found the top so abort the recursion

    Vec2 searchMin(std::max(0, node.pos.x-1), std::max(0, node.pos.y-1));
    Vec2 searchMax(std::min(map.Width(), node.pos.x+2), std::min(map.Height(), node.pos.y+2));

    for(int x=searchMin.x; x < searchMax.x; ++x)
    {
        for(int y=searchMin.y; y < searchMax.y; ++y)
        {
            int upValue = node.value + 1;
            if(map.Get(x, y) == upValue)
            {
                Node newNode;
                newNode.pos.x = x;
                newNode.pos.y = y;
                newNode.value = upValue;
                node.nextNodes.push_back(newNode);
                Node& ref = *node.nextNodes.end();
                BuildNodeGraph(ref, map);
            }
        }
    }
}

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    StringVector lines = GetFileAsLines(filename);
    int width = lines[0].size();
    int height = lines.size();

    Grid2D<int> map(width, height);
    std::vector<Node> startNodes;

    for(int y=0 ; y<height ; y++)
    {
        for(int x=0; x<height ; x++)
        {
            map.Set(x, y, lines[y][x] - '0');
            if(map.Get(x, y) == 0)
            {
                Node n;
                n.pos = {x, y};
                n.value = 0;
                startNodes.push_back(n);
            }
        }
    }

    for(Node node : startNodes)
    {
        BuildNodeGraph(node, map);
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

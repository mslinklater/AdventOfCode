#include <cassert>
#include <string>
#include <algorithm>
#include <list>

#include "utils.h"

struct Node
{
    Node(){}
    virtual ~Node()
    {
        for(auto node : nextNodes)
            delete node;
    }

    Vec2 pos;
    int value;
    std::vector<Node*> nextNodes;

    int GetRoutesFromHere()
    {
        if(value == 9)
        {
            return 1;
        }
        else
        {
            if(nextNodes.size() == 0)
            {
                return 0;
            }
            else
            {
                int sum = 0;
                for(Node* next : nextNodes)
                {
                    sum += next->GetRoutesFromHere();
                }
                return sum;
            }
        }
    }

    static std::set<Vec2> nineSet;
};

std::set<Vec2> Node::nineSet;

void BuildNodeGraph(Node* node, const Grid2D<int>& map)
{
    if(node->value == 9)
    {
        Node::nineSet.insert(node->pos);
        return;
    }

    std::vector<Vec2> searchPositions;

    if(node->pos.x > 0) searchPositions.push_back(Vec2(node->pos.x-1, node->pos.y));
    if(node->pos.x < map.Width() - 1) searchPositions.push_back(Vec2(node->pos.x+1, node->pos.y));
    if(node->pos.y > 0) searchPositions.push_back(Vec2(node->pos.x, node->pos.y-1));
    if(node->pos.y < map.Height() - 1) searchPositions.push_back(Vec2(node->pos.x, node->pos.y+1));

    for(Vec2 pos : searchPositions)
    {
        int upValue = node->value + 1;
        if(map.Get(pos.x, pos.y) == upValue)
        {
            Node* newNode = new Node();
            newNode->pos.x = pos.x;
            newNode->pos.y = pos.y;
            newNode->value = upValue;
            node->nextNodes.push_back(newNode);
            BuildNodeGraph(newNode, map);
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
    std::vector<Node*> startNodes;

    for(int y=0 ; y<height ; y++)
    {
        for(int x=0; x<height ; x++)
        {
            map.Set(x, y, lines[y][x] - '0');
            if(map.Get(x, y) == 0)
            {
                Node* n = new Node();
                n->pos = {x, y};
                n->value = 0;
                startNodes.push_back(n);
            }
        }
    }

    for(Node* node : startNodes)
    {
        Node::nineSet.clear();
        BuildNodeGraph(node, map);
        if(part == 1)
        {
            answer += Node::nineSet.size();
        }
        else
        {
            answer += node->GetRoutesFromHere();
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
    assert(Solve("../input/day10test", 2) == 81);

    assert(Solve("../input/day10", 1) == 617);
    assert(Solve("../input/day10", 2) == 1477);

    std::cout << "problem 1:" << Solve("../input/day10", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day10", 2) << std::endl;

    return 0;
}

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
    int width = lines[0].size();
    int height = lines.size();

    Grid2D<Cell> map(width, height);
    std::map<char, std::vector<Vec2>> transmitters;

    // populate map
    for(int y=0 ; y<lines.size() ; y++)
    {
        for(int x=0; x<lines[0].size() ; x++)
        {
            Cell c = {lines[y][x], false};
            map.Set(x, y, c);
        }
    }

    for(int x = 0; x < width ; x++)
    {
        for(int y = 0; y < height ; y++)
        {
            const Cell& c = map.Get(x, y);
            if(c.val != '.')
            {
                transmitters[c.val].push_back(Vec2(x, y));
            }
        }
    }

        for(auto e : transmitters)
        {
            for(int i=0 ; i<e.second.size() ; i++)
            {
                for(int j=i+1 ; j<e.second.size() ; j++)
                {
                    Vec2 delta = e.second[i] - e.second[j];


                    if(part == 1)
                    {
                        Vec2 first = e.second[i] + delta;
                        Vec2 second = e.second[j] - delta;
                        if(map.Inside(first.x, first.y))
                        {
                            Cell& c = map.GetMutable(first.x, first.y);
                            c.antinode = true;
                        }

                        if(map.Inside(second.x, second.y))
                        {
                            Cell& c = map.GetMutable(second.x, second.y);
                            c.antinode = true;
                        }
                    }
                    else
                    {
                        Vec2 first = e.second[i];
                        Vec2 second = e.second[j];
                        while(map.Inside(first.x, first.y))
                        {
                            Cell& c = map.GetMutable(first.x, first.y);
                            c.antinode = true;
                            first = first + delta;
                        }
                        while(map.Inside(second.x, second.y))
                        {
                            Cell& c = map.GetMutable(second.x, second.y);
                            c.antinode = true;
                            second = second - delta;
                        }
                    }
                }
            }
        }

        for(int x=0 ; x<width ; x++)
        {
            for(int y=0 ; y<height ; y++)
            {
                if(map.Get(x,y).antinode)
                    answer++;
            }
        }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day8test", 1) == 14);
    assert(Solve("../input/day8test", 2) == 34);
    
    assert(Solve("../input/day8", 1) == 400);
    assert(Solve("../input/day8", 2) == 1280);

    std::cout << "problem 1:" << Solve("../input/day8", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day8", 2) << std::endl;

    return 0;
}
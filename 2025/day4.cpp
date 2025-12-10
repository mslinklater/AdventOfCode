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

std::vector<Vec2> GetRemovables()
{
    std::vector<Vec2> ret;
    for(int x=0 ; x<data.Width() ; ++x)
    {
        for(int y=0 ; y<data.Height() ; ++y)
        {
            if(data.Get(x, y) == '@')
            {
                int numNeighbors = 0;
                for(int xTest = x-1 ; xTest < x+2 ; xTest++)
                {
                    for(int yTest = y-1 ; yTest < y+2 ; yTest++)
                    {
                        if(data.Inside(xTest, yTest) && !(xTest == x && yTest == y))
                        {
                            char val = data.Get(xTest, yTest);
                            if(val == '@')
                            {
                                numNeighbors++;
                            }   
                        }
                    }
                }
                if(numNeighbors < 4)
                {
                    ret.push_back(Vec2(x, y));
                }
            }
        }
    }
    return ret;
}

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;

    LoadData(filename);

    if(part == 1)
    {
        answer = GetRemovables().size();
    }
    else
    {
        std::vector<Vec2> removables;
        do
        {
            removables = GetRemovables();
            answer += removables.size();
            for(const Vec2& v : removables)
            {
                data.Set(v.x, v.y, '.');
            }
        } while(removables.size() > 0);
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day4test", 1) == 13);
    assert(Solve("../input/day4", 1) == 1537);

    assert(Solve("../input/day4test", 2) == 43);
    assert(Solve("../input/day4", 2) == 8707);

    std::cout << "problem 1:" << Solve("../input/day4", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day4", 2) << std::endl;

    return 0;
}

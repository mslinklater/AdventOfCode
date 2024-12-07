#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Cell
{
    char c;
    bool visited = false;
};

template<class T>
class Grid2D
{
public:
    Grid2D(int width, int height)
    {
        for(int y=0 ; y<height ; ++y)
        {
            std::vector<T> row;
            row.resize(width);
            e.push_back(row);
        }
    }

    void Set(int x, int y, const T& val)
    {
        e[y][x] = val;
    }
    const T& Get(int x, int y)
    {
        return e[y][x];
    }
    T& GetMutable(int x, int y)
    {
        return e[y][x];
    }

    int Height()
    {
        return e.size();
    }

    int Width()
    {
        return e[0].size();
    }

private:
    std::vector<std::vector<T>> e;
};

//-------------------------

bool Walk(Grid2D<Cell>& grid)
{
    Vec2 pos;
    EDirection dir = EDirection::Up;

    int width = grid.Width();
    int height = grid.Height();

    for(int y = 0; y < height ; y++)
    {
        for(int x = 0; x < width ; x++)
        {
            Cell& c = grid.GetMutable(x,y);
            c.visited = false;
            if(c.c == '^')
            {
                pos.x = x;
                pos.y = y;
                c.visited = true;
            }
        }
    }

    int steps = 0;

    while(pos.x >= 0 && pos.x < width && pos.y >= 0 && pos.y < height && steps < (width * height))
    {
        Cell& cellRef = grid.GetMutable(pos.x, pos.y);
        cellRef.visited = true;
        
        switch(dir)
        {
            case EDirection::Up:
                if((pos.y == 0) || (grid.Get(pos.x, pos.y - 1).c != '#'))
                {
                    pos.y -= 1;
                }
                else
                {
                    dir = EDirection::Right;
                }
                break;
            case EDirection::Right:
                if((pos.x == width-1) || (grid.Get(pos.x + 1, pos.y).c != '#'))
                {
                    pos.x += 1;
                }
                else
                {
                    dir = EDirection::Down;
                }
                break;
            case EDirection::Down:
                if((pos.y == height-1) || (grid.Get(pos.x, pos.y + 1).c != '#'))
                {
                    pos.y += 1;
                }
                else
                {
                    dir = EDirection::Left;
                }
                break;
            case EDirection::Left:
                if((pos.x == 0) || (grid.Get(pos.x - 1, pos.y).c != '#'))
                {
                    pos.x -= 1;
                }
                else
                {
                    dir = EDirection::Up;
                }
                break;
            default:
                break;
        }
        steps++;
    }

    if(steps < (width * height))
        return false;
    else
        return true;
}

//-------------------------

int Solve(const std::string& filename, int part)
{
    int answer = 0;
    Vec2 pos;
    StringVector map = GetFileAsLines(filename);
    int width = map[0].size();
    int height = map.size();
    Grid2D<Cell> grid(width, height);

    for(int y = 0; y < map.size() ; y++)
    {
        for(int x = 0; x < map[0].size() ; x++)
        {
            Cell c;
            c.c = map[y][x];
            grid.Set(x, y, c);
        }
    }

    if(part == 1)
    {
        Walk(grid);
        for(int x=0 ; x<width ; ++x)
        {
            for(int y=0 ; y<height ; y++)
            {
                if(grid.Get(x,y).visited)
                    answer++;
            }
        }
    }
    else
    {
        for(int blockX = 0; blockX < width ; blockX++)
        {
            for(int blockY = 0; blockY < width ; blockY++)
            {
                Grid2D<Cell> testGrid = grid;
                if(testGrid.Get(blockX,blockY).c == '.')
                {
                    Cell c;
                    c.visited = false;
                    c.c = '#';
                    testGrid.Set(blockX, blockY, c);

                    if(Walk(testGrid))
                    {
                        answer++;
                    }
                }
            }
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day6test", 1) == 41);
    assert(Solve("../input/day6test", 2) == 6);
    
    assert(Solve("../input/day6", 1) == 4973);
    assert(Solve("../input/day6", 2) == 1482);

    std::cout << "problem 1:" << Solve("../input/day6", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day6", 2) << std::endl;

    return 0;
}
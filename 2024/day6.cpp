#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

template<class T>
class Grid2D
{
public:
    Grid2D(int width, int height)
    {
        for(int y=0 ; y<height ; ++y)
        {
            std::vector<T> row;
            row.reserve(width);
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

private:
    std::vector<std::vector<T>> e;
};

int Solve(const std::string& filename, int part)
{
    int answer = 0;
    StringVector map = GetFileAsLines(filename);



    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day5test", 1) == 41);
//    assert(Solve("../input/day5test", 2) == 123);
    
//    assert(Solve("../input/day5", 1) == 5091);
//    assert(Solve("../input/day5", 2) == 4681);

    std::cout << "problem 1:" << Solve("../input/day5", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day5", 2) << std::endl;

    return 0;
}
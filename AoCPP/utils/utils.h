#pragma once
#include <set>
#include <map>
#include <fstream>
#include <iostream>
#include <sstream>

#include "utiltypes.h"

//-------------------------------------
// Enums
//-------------------------------------

enum class EDirection
{
    Up = 0,
    Down,
    Left,
    Right,
    Num
};

//-------------------------------------
// Vec2
//-------------------------------------

struct Vec2
{
    int x;
    int y;

    Vec2(){}

    Vec2(float _x, float _y)
    : x(_x)
    , y(_y)
    {}

    bool operator<(const Vec2& other) const {
        if(x == other.x) return y < other.y;
        else return x < other.x;
    }

    Vec2 operator-(const Vec2& v) const {
        return Vec2(this->x - v.x, this->y - v.y);
    }

    Vec2 operator+(const Vec2& v) const {
        return Vec2(this->x + v.x, this->y + v.y);
    }
};

typedef std::vector<Vec2> Vec2Vector;

//-------------------------------------
// general purpose 2D grid
//-------------------------------------

template<class T>
class Grid2D
{
public:
    Grid2D(){}
    virtual ~Grid2D(){}

    void Initialize(int _width, int _height)
    {
        width = _width;
        height = _height;
        e.clear();
        for(int y=0 ; y<height ; ++y)
        {
            std::vector<T> row;
            row.resize(width);
            e.push_back(row);
        }
    }

    Grid2D(int _width, int _height)
    : width(_width)
    , height(_height)
    {
        Initialize(width, height);
    }

    bool Inside(int x, int y) const
    {
        return x >= 0 && x < width && y >= 0 && y < height;
    }

    void Set(int x, int y, const T& val)
    {
        e[y][x] = val;
    }
    const T& Get(int x, int y) const
    {
        return e[y][x];
    }
    T& GetMutable(int x, int y)
    {
        return e[y][x];
    }

    int Height() const
    {
        return e.size();
    }

    int Width() const
    {
        return e[0].size();
    }

private:
    int width = 0;
    int height = 0;
    std::vector<std::vector<T>> e;
};

StringVector GetFileAsLines(Path path);

String GetFileAsSingleLine(Path path);

// String helpers

template <typename T>
int FindIndexOf(const std::vector<T>& vec, const T& element)
{
    auto i = std::find(vec.begin(), vec.end(), element);
    return i != vec.end() ? std::distance(vec.begin(), i) : -1;
}

#if 0
StringVector SplitStringByChar(const String& str, char c) 
{
    StringVector ret;
    String sub;
    std::istringstream tokenStream(str);
    
    while (std::getline(tokenStream, sub, c)) 
    {
        ret.push_back(sub);
    }
    
    return ret;
}

IntVector IntVecFromStringVec(const StringVector strvec)
{
    IntVector ret;
    for(auto s : strvec)
    {
        ret.push_back(std::stoi(s));
    }
    return ret;
}

ULongVector ULongVecFromStringVec(const StringVector strvec)
{
    ULongVector ret;
    for(auto s : strvec)
    {
        ret.push_back(std::stoll(s));
    }
    return ret;
}

IntVector PositionsOfString(String pattern, String data)
{
    IntVector ret;
    int search = 0;
    while(search != std::string::npos)
    {
        search = data.find(pattern, search);
        if(search != std::string::npos)
        {
            ret.push_back(search);
            search++;
        }
    }
    return ret;
}

bool DoesMatch2D(const StringVector& pattern, const StringVector& data, Vec2 pos, char ignore)
{
    if(pattern.size() + pos.y > data.size())
        return false;
    if(pattern[0].size() + pos.x > data[0].size())
        return false;

    bool match = true;
    for(int x=0 ; x<pattern[0].size() ; ++x)
    {
        for(int y=0 ; y<pattern.size() ; ++y)
        {
            if(pattern[y][x] != ignore)
            {
                if(data[y+pos.y][x+pos.x] != pattern[y][x])
                {
                    match = false;
                }
            }
        }
    }
    return match;
}

std::vector<int> IntToBaseDigits(int num, int base, int minDigits);

#endif

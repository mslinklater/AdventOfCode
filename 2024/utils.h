#include <vector>
#include <string>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>

typedef std::string String;
typedef std::filesystem::path Path;
typedef std::vector<String> StringVector;
typedef std::vector<int> IntVector;

enum class EDirection
{
    Up = 0,
    Down,
    Left,
    Right,
    Num
};

struct Vec2
{
    int x;
    int y;
};

StringVector GetFileAsLines(Path path)
{
    StringVector lines;
    std::ifstream infile;

    infile.open(path);
    if(infile.is_open())
    {
        String line;
        while(std::getline(infile, line))
        {
            lines.push_back(line);
        }
    }

    return lines;
}

String GetFileAsSingleLine(Path path)
{
    String ret;
    std::ifstream infile;

    infile.open(path);
    if(infile.is_open())
    {
        String line;
        while(std::getline(infile, line))
        {
            ret.append(line);
        }
    }

    return ret;
}

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

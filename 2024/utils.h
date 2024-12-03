#include <vector>
#include <string>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>

std::vector<std::string> GetFileAsLines(std::filesystem::path path)
{
    std::vector<std::string> lines;
    std::ifstream infile;

    infile.open(path);
    if(infile.is_open())
    {
        std::string line;
        while(std::getline(infile, line))
        {
            lines.push_back(line);
        }
    }

    return lines;
}

std::string GetFileAsSingleLine(std::filesystem::path path)
{
    std::string ret;
    std::ifstream infile;

    infile.open(path);
    if(infile.is_open())
    {
        std::string line;
        while(std::getline(infile, line))
        {
            ret.append(line);
        }
    }

    return ret;
}

std::vector<std::string> SplitStringByChar(const std::string& str, char c) 
{
    std::vector<std::string> ret;
    std::string sub;
    std::istringstream tokenStream(str);
    
    while (std::getline(tokenStream, sub, c)) 
    {
        ret.push_back(sub);
    }
    
    return ret;
}

std::vector<int> IntVecFromStringVec(const std::vector<std::string> strvec)
{
    std::vector<int> ret;
    for(auto s : strvec)
    {
        ret.push_back(std::stoi(s));
    }
    return ret;
}

std::vector<int> PositionsOfString(std::string pattern, std::string data)
{
    std::vector<int> ret;
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
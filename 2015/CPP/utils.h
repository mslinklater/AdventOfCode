#include <vector>
#include <string>
#include <filesystem>
#include <fstream>
#include <iostream>

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

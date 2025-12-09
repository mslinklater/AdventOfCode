#include "utils.h"

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
    else
    {
        std::cout << "Failed to open file: " << path << std::endl;
        std::cout << "Current working directory: " << std::filesystem::current_path() << std::endl;
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

std::vector<int> IntToBaseDigits(int num, int base, int minDigits)
{
    std::vector<int> ret;
    while((num > 0) || (ret.size() < minDigits))
    {
        int remainder = num % base;
        ret.push_back(remainder);
        num /= base;
    }
    return ret;
}
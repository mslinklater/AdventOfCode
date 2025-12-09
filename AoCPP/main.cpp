#include <iostream>

#include "2025/2025.h"

void Banner()
{
    std::cout << "=====================" << std::endl;
    std::cout << "Advent of Code in C++" << std::endl;
    std::cout << "=====================" << std::endl;
}

bool ParseArgs(int argc, const char** argv, int& year, int& day)
{
    if (argc < 3)
    {
        std::cerr << "Usage: " << argv[0] << " <year> <day>" << std::endl;
        return false;
    }
    year = std::stoi(argv[1]);
    day = std::stoi(argv[2]);
    std::cout << "Year: " << year << ", Day: " << day << std::endl;
    return true;
}

int main(int argc, const char** argv)
{
    Banner();
    // parse command line arguments
    int year = 0;
    int day = 0;
    if (!ParseArgs(argc, argv, year, day))
    {
        return 1;
    }

    return 0;
}
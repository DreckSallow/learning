// See https://aka.ms/new-console-template for more information

Console.WriteLine("Creating Random Number...");
int globalNumber = RandomInt.getRandomInt();
int totalTries = 8;
int attemptsMade = 0;

while (attemptsMade < totalTries)
{
    Console.WriteLine("Guess the number: ");
    Console.Write("> ");
    string? inputNumber = Console.ReadLine();
    attemptsMade += 1;
    Console.WriteLine();
    Console.WriteLine($"-> missing attempts {(totalTries - attemptsMade)} ");
    if (inputNumber == null || inputNumber.Length == 0)
    {
        continue;
    }

    int parsedNumber = 0;
    try
    {
        parsedNumber = int.Parse(inputNumber);
    }
    catch (FormatException e)
    {
        continue;
    }
    if (parsedNumber < globalNumber)
    {
        Console.WriteLine("Nope! The number entered is less.");
    }
    else if (parsedNumber > globalNumber)
    {
        Console.WriteLine("Nope! The number entered is greater. >");
    }
    else
    {
        Console.WriteLine("Yeah You guess the number!");
    }
}

class RandomInt
{
    public static int getRandomInt()
    {
        Random rn = new Random();
        return rn.Next(101);
    }
}


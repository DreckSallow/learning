// See https://aka.ms/new-console-template for more information

int globalNumber = RandomInt.getRandomInt();
int totalTries = 4;
List<int> numbersEntered = new List<int>();
int initialLeft = Console.CursorLeft;
int top = Console.CursorTop;
while (numbersEntered.Count < totalTries)
{
    Console.SetCursorPosition(initialLeft, top);// Set the initial Cursor
    Console.Clear();
    // Console.WriteLine($"{globalNumber}");
    Console.Write("History: ");
    bool findPosition = false;
    for (int i = 0; i < numbersEntered.Count; i += 1)
    {
        int currentVal = numbersEntered[i];
        if (currentVal < globalNumber)
        {
            if (i + 1 == numbersEntered.Count) Console.Write($"{currentVal} - X");
            else Console.Write($"{currentVal} - ");
        }
        else if (currentVal > globalNumber)
        {
            if (!findPosition)
            {
                findPosition = true;
                Console.Write($" X - {currentVal} - ");
            }
            else Console.Write($"{currentVal} - ");
        }
    }
    Console.WriteLine("\nGuess the number: ");
    Console.Write("> ");

    string? inputNumber = Console.ReadLine();
    int parsedNumber;

    if (!int.TryParse(inputNumber, out parsedNumber)) continue;
    numbersEntered.Add(parsedNumber); // Add the new number
    numbersEntered.Sort();// Sort the list
    if (parsedNumber == globalNumber)
    {
        Console.WriteLine("Yeah You guess the number!");
        break;
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


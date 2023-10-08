// See https://aka.ms/new-console-template for more information

(string, byte)[] modes = new (string, byte)[] { ("easy", 12), ("normal", 8), ("hard", 6), ("hardcore", 4) };
byte modeNumber = modes[1].Item2;
if (args.Length > 0)
{
    string[] arg = args[0].Split("=");
    if (arg[0] == "--mode")
    {
        string modeVal;
        try
        {
            modeVal = arg[1].Trim().ToLower();
        }
        catch (System.IndexOutOfRangeException)
        {
            Console.WriteLine($"Mode not found! Try --mode={String.Join(",", modes.Select(it => it.Item1))}");
            return 1;
        }

        byte? findedLevel = null;
        foreach ((string, byte) it in modes)
        {
            if (it.Item1 == modeVal)
            {
                findedLevel = it.Item2;
                break;
            }
        }

        if (findedLevel.HasValue) modeNumber = findedLevel.Value;
        else
        {
            Console.WriteLine($"Mode not found! Try --mode={String.Join(",", modes.Select(it => it.Item1))}");
            return 1;
        }
    }
}

new ConsoleApp(modeNumber).Run();// Execute the app using the level provided by the user
return 0;

struct TerminalUtil
{
    private int CursorTop;
    private int CursorLeft;
    public TerminalUtil()
    {
        CursorTop = Console.CursorTop;
        CursorLeft = Console.CursorLeft;
    }
    public void Restore()
    {
        Console.SetCursorPosition(CursorLeft, CursorTop);
    }
}


class ConsoleApp
{
    private byte TotalCount;
    private int GuessNumber;
    public ConsoleApp(byte totalCount)
    {
        TotalCount = totalCount;
        GuessNumber = ConsoleApp.GetRandomInt();
    }
    public void Run()
    {
        TerminalUtil term = new TerminalUtil();
        List<int> numbersEntered = new List<int>();
        while (numbersEntered.Count < TotalCount)
        {
            term.Restore();// Set the initial Cursor
            Console.Clear();
            Console.WriteLine($"Missing attempts: {TotalCount - numbersEntered.Count}");
            Console.Write("History: ");
            bool findPosition = false;
            for (int i = 0; i < numbersEntered.Count; i += 1)
            {
                int currentVal = numbersEntered[i];
                if (currentVal < GuessNumber)
                {
                    if (i + 1 == numbersEntered.Count) Console.Write($"{currentVal} - X");
                    else Console.Write($"{currentVal} - ");
                }
                else if (currentVal > GuessNumber)
                {
                    if (!findPosition)
                    {
                        findPosition = true;
                        Console.Write($" X - {currentVal}");
                    }
                    else Console.Write($"{currentVal}");
                    if (i + 1 < numbersEntered.Count) Console.Write(" -");
                }
            }
            Console.WriteLine("\nGuess the number: ");
            Console.Write("> ");

            string? inputNumber = Console.ReadLine();
            int parsedNumber;

            if (!int.TryParse(inputNumber, out parsedNumber)) continue;
            numbersEntered.Add(parsedNumber); // Add the new number
            numbersEntered.Sort();// Sort the list
            if (parsedNumber == GuessNumber)
            {
                Console.WriteLine("🎉 Yeah! You guess the number!🎉");
                break;
            }
        }
        if (!numbersEntered.Contains(GuessNumber)) Console.WriteLine("No worries, try again! You'll get it.");
    }
    public static int GetRandomInt()
    {
        Random rn = new Random();
        return rn.Next(101);
    }
}

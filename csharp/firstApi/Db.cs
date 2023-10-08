namespace FirstApi.DB;

public record Person
{
    public int Id { get; set; }
    public string Name { get; set; }
    public int Age { get; set; }
    public Person(int id, string name, int age)
    {
        Id = id;
        Name = name;
        Age = age;
    }
}

public class PeopleDb
{
    private List<Person> _people = new List<Person>();
    public PeopleDb(uint total)
    {

        for (int i = 0; i < 20; i++)
        {
            _people.Add(
                new Person(
                    i + 1,
                    $"Person {i + 1}",
                    new Random().Next(18, 60) // Edad aleatoria entre 18 y 60
                )
            );
        }
    }
    public List<Person> GetAll() => _people;
    public Person? GetOne(int id) => _people.SingleOrDefault(p => p.Id == id);
    public Person CreatePerson(Person p)
    {
        _people.Add(p);
        return p;
    }
    public Person? UpdateName(int id, string newName)
    {
        Person? finded = GetOne(id);
        if (finded == null)
        {
            return null;
        }
        _people = _people.Select(p =>
        {
            if (p.Id == id) p.Name = newName;
            return p;
        }).ToList();

        return new Person(id, newName, finded.Age);
    }
    // public void 
    public Person? Delete(int id)
    {
        Person? finded = GetOne(id);
        if (finded == null)
        {
            return null;
        }
        _people = _people.FindAll(p => p.Id != id).ToList();
        return finded;
    }
}


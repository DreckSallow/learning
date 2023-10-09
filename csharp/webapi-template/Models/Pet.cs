namespace webapi_template.Models;

public enum TypeOfPet
{
    Flying,
    Terrestrial,
    Acuatic
}

public class Pet
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public TypeOfPet Type { get; set; }
}

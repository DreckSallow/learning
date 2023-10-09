using webapi_template.Models;

namespace webapi_template.Service;


public static class PetService
{
    static List<Pet> Pets { get; }
    static int nextId = 3;
    static PetService()
    {
        Pets = new List<Pet>{
            new Pet{Id=1,Name="Fido",Type=TypeOfPet.Terrestrial},
            new Pet{Id=2,Name="Aero",Type=TypeOfPet.Flying},
        };

    }
    public static List<Pet> GetAll() => Pets;
    public static Pet? GetOne(int id) => Pets.FirstOrDefault(p => p.Id == id);
    public static Pet Add(Pet pet)
    {
        pet.Id = nextId++;
        Pets.Add(pet);
        return pet;
    }
    public static Pet? Delete(int pId)
    {
        var pet = GetOne(pId);
        if (pet != null)
        {
            if (Pets.Remove(pet)) nextId--;
        }
        return pet;
    }
    public static Pet? Update(Pet pet)
    {
        var index = Pets.FindIndex(p => p.Id == pet.Id);
        if (index == -1)
        {
            return null;
        }
        Pets[index] = pet;
        return pet;
    }
}
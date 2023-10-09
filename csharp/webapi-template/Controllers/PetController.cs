using Microsoft.AspNetCore.Mvc;

using webapi_template.Models;
using webapi_template.Service;
namespace webapi_template.Controllers;


[ApiController]
[Route("[controller]")]
public class PetsController : ControllerBase
{
    public PetsController()
    {

    }

    [HttpGet]
    public ActionResult<List<Pet>> GetAll() => PetService.GetAll();

    [HttpGet("{id}")]
    public ActionResult<Pet> Get(int id)
    {
        var pet = PetService.GetOne(id);
        if (pet == null) return NotFound();
        return pet;
    }

    [HttpPost]
    public IActionResult Create(Pet pet)
    {
        var newPet = PetService.Add(pet);
        if (newPet == null)
        {
            return BadRequest();
        }
        return CreatedAtAction(nameof(Get), new { id = pet.Id }, newPet);
    }

    [HttpPut("{id}")]
    public ActionResult<Pet> Update(int id, Pet pet)
    {
        if (id != pet.Id) return BadRequest();
        var updated = PetService.Update(pet);
        if (updated is null) return NotFound();
        return updated;
    }

    [HttpDelete("{id}")]
    public ActionResult<Pet> Delete(int id)
    {
        var deleted = PetService.Delete(id);
        if (deleted is null) return NotFound();
        return deleted;

    }
}
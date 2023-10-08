using Microsoft.OpenApi.Models;

using FirstApi.DB;

var builder = WebApplication.CreateBuilder(args);
// Setup the wagger documentation.
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "FIRST API", Description = "First app for web API", Version = "v1" });
});
var app = builder.Build();


PeopleDb Store = new PeopleDb(20);

app.MapGet("/", () => "Hello World!");
app.MapGet("/persons", () =>
{
    return new Response<List<Person>>
    {
        Message = "People obtained.",
        Data = Store.GetAll()
    };
});
app.MapGet("/persons/{id}", (int id) =>
{
    Person? p = Store.GetOne(id);
    return new Response<Person>
    {
        Message = p == null ? "Person not found." : "Person obtained.",
        Data = p
    };
});
app.MapPost("/persons", (Person p) =>
{
    return new Response<Person>
    {
        Message = "Person created!.",
        Data = Store.CreatePerson(p)
    };

});
app.MapPut("/persons/{id}", (int id, string name) =>
{
    Person? updated = Store.UpdateName(id, name);
    return new Response<Person>
    {
        Message = updated == null ? "Person not found" : "Person updated!",
        Data = updated,
    };
});

app.MapDelete("/persons/{id}", (int id) =>
{
    Person? p = Store.Delete(id);
    return new Response<Person>
    {
        Message = p == null ? "Person not found." : "Person removed!",
        Data = p,
    };
});
// Read the swagger configuration
// And execute the middleware
app.UseSwagger();
app.UseSwaggerUI((c) =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "First API in C#");
});

app.Run();

struct Response<T>
{
    public string Message { get; set; }
    public T? Data { get; set; }
}

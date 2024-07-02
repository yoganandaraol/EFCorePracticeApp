using Microsoft.EntityFrameworkCore;
using NorthwindApi.Context;
using NorthwindApi.Services;

namespace NorthwindApi;

public static class DependencyInjection
{
    public static void AddNorthwindDbContext(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<INorthwindDbContext, NorthwindDbContext>(options => 
            options.UseSqlServer(configuration.GetConnectionString("NorthwindDb")));
    }

    public static void AddServices(this IServiceCollection services)
    {
        services.AddTransient<IProductsService, ProductsService>();
    }
}
using Microsoft.EntityFrameworkCore;
using NorthwindApi.Context;
using NorthwindApi.Entities;

namespace NorthwindApi.Services;

public interface IProductsService
{
    Task<IEnumerable<Product>> GetProducts(CancellationToken cancellationToken);

    Task<Product?> GetProduct(int productId, CancellationToken cancellationToken);
}

public class ProductsService(INorthwindDbContext dbContext) : IProductsService
{
    public async Task<IEnumerable<Product>> GetProducts(CancellationToken cancellationToken) =>
        await dbContext.Products.AsNoTracking().ToListAsync(cancellationToken);

    public async Task<Product?> GetProduct(int productId, CancellationToken cancellationToken)
    {
        var product = await dbContext.Products.AsNoTracking()
            .FirstOrDefaultAsync(p => p.ProductId == productId, cancellationToken);
        return product;
    }
}
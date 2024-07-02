using AutoMapper;
using Microsoft.EntityFrameworkCore;
using NorthwindApi.Context;
using NorthwindApi.Dtos;

namespace NorthwindApi.Services;

public interface IProductsService
{
    Task<IEnumerable<ProductDto>> GetProducts(CancellationToken cancellationToken);

    Task<ProductDto?> GetProduct(int productId, CancellationToken cancellationToken);
}

public class ProductsService(INorthwindDbContext dbContext, IMapper mapper) : IProductsService
{
    public async Task<IEnumerable<ProductDto>> GetProducts(CancellationToken cancellationToken)
    {
        var result = await dbContext.Products.AsNoTracking().ToListAsync(cancellationToken);
        var products = mapper.Map<IEnumerable<ProductDto>>(result);
        return products;
    }

    public async Task<ProductDto?> GetProduct(int productId, CancellationToken cancellationToken)
    {
        var result = await dbContext.Products.AsNoTracking()
            .FirstOrDefaultAsync(p => p.ProductId == productId, cancellationToken);
        var product = mapper.Map<ProductDto>(result);
        return product;
    }
}
using Microsoft.AspNetCore.Mvc;
using NorthwindApi.Models;
using NorthwindApi.Services;

namespace NorthwindApi.Controllers;

public class ProductsController(IProductsService productsService) : BaseApiController
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Product>>> GetProducts(CancellationToken cancellationToken)
    {
        var products = await productsService.GetProducts(cancellationToken);
        return Ok(products);
    }

    [HttpGet]
    [Route("/{productId}")]
    public async Task<ActionResult<Product>> GetProduct([FromRoute] string productId, CancellationToken cancellationToken)
    {
        if (!int.TryParse(productId, out var itemId))
            return BadRequest("Invalid ProductId");
        
        var product = await productsService.GetProduct(itemId, cancellationToken);
        return Ok(product);

    }
}
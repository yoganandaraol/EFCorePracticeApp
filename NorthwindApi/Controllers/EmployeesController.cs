using Microsoft.AspNetCore.Mvc;
using NorthwindApi.Dtos;
using NorthwindApi.Services;

namespace NorthwindApi.Controllers;

public class EmployeesController(IEmployeesService employeesService) : BaseApiController
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<EmployeeDto>>> GetEmployeesAsync(CancellationToken cancellationToken)
    {
        var employees = await employeesService.GetEmployeesAsync(cancellationToken);
        return Ok(employees);
    }
}
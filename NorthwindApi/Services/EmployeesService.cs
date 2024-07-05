using Microsoft.EntityFrameworkCore;
using NorthwindApi.Context;
using NorthwindApi.Entities;
using AutoMapper;
using NorthwindApi.Dtos;

namespace NorthwindApi.Services;

public interface IEmployeesService
{
    Task<IEnumerable<EmployeeDto>> GetEmployeesAsync(CancellationToken cancellationToken);

    Task<EmployeeDto?> GetEmployeeAsync(int empId, CancellationToken cancellationToken);
}

public class EmployeesService(INorthwindDbContext dbContext, IMapper mapper) : IEmployeesService
{
    public async Task<IEnumerable<EmployeeDto>> GetEmployeesAsync(CancellationToken cancellationToken)
    {
        var result = await dbContext.Employees.AsNoTracking()
            .Select(emp => new EmployeeDto
            {
                EmployeeId = emp.EmployeeId,
                FirstName = emp.FirstName,
                LastName = emp.LastName,
                Photo = emp.PhotoBase64, //Convert.ToBase64String(emp.Photo ?? Array.Empty<byte>()),
                PhotoPath = emp.PhotoPath,
                BirthDate = emp.BirthDate,
                Title = emp.Title
            })
            .ToListAsync(cancellationToken);
        //var employees = mapper.Map<IEnumerable<EmployeeDto>>(result);
        return result;
    }

    public async Task<EmployeeDto?> GetEmployeeAsync(int empId, CancellationToken cancellationToken)
    {
        var result = await dbContext.Employees.AsNoTracking()
            .FirstOrDefaultAsync(p => p.EmployeeId == empId, cancellationToken);
        var employee = mapper.Map<EmployeeDto>(result);
        return employee;
    }
}
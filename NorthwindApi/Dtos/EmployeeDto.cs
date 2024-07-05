using NorthwindApi.Entities;

namespace NorthwindApi.Dtos;

public class EmployeeDto : IMapFrom<Employee>
{
    public int EmployeeId { get; set; }

    public string LastName { get; set; } = null!;

    public string FirstName { get; set; } = null!;
    
    //public byte[]? Photo { get; set; }

    public string? Photo { get; set; } = string.Empty;
    
    public string? PhotoPath { get; set; }

    public string? Title { get; set; }
    
    public DateTime? BirthDate { get; set; }
    /*
    public DateTime? HireDate { get; set; }

    public string? Address { get; set; }

    public string? City { get; set; }

    public string? Region { get; set; }

    public string? PostalCode { get; set; }

    public string? Country { get; set; }

    public string? HomePhone { get; set; }

    public string? Extension { get; set; }

    public virtual EmployeeDto? ReportsToNavigation { get; set; }
    */
}
using AutoMapper;
using NorthwindApi.Entities;

namespace NorthwindApi.Dtos;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<Employee, EmployeeDto>();
        CreateMap<Product, ProductDto>();
    }
}
using AutoMapper;

namespace NorthwindApi.Dtos;

public interface IMapFrom<T>
{
    void Mapping(Profile profile) => profile.CreateMap(typeof(T), GetType());
}
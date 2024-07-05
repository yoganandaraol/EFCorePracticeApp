﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace NorthwindApi.Migrations
{
    /// <inheritdoc />
    public partial class TASK0001_AddPhotoBase64ColumnToEmployeeTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "PhotoBase64",
                table: "Employees",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PhotoBase64",
                table: "Employees");
        }
    }
}

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Categories] (
        [CategoryID] int NOT NULL IDENTITY,
        [CategoryName] nvarchar(15) NOT NULL,
        [Description] ntext NULL,
        [Picture] image NULL,
        CONSTRAINT [PK_Categories] PRIMARY KEY ([CategoryID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [CustomerDemographics] (
        [CustomerTypeID] nchar(10) NOT NULL,
        [CustomerDesc] ntext NULL,
        CONSTRAINT [PK_CustomerDemographics] PRIMARY KEY NONCLUSTERED ([CustomerTypeID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Customers] (
        [CustomerID] nchar(5) NOT NULL,
        [CompanyName] nvarchar(40) NOT NULL,
        [ContactName] nvarchar(30) NULL,
        [ContactTitle] nvarchar(30) NULL,
        [Address] nvarchar(60) NULL,
        [City] nvarchar(15) NULL,
        [Region] nvarchar(15) NULL,
        [PostalCode] nvarchar(10) NULL,
        [Country] nvarchar(15) NULL,
        [Phone] nvarchar(24) NULL,
        [Fax] nvarchar(24) NULL,
        CONSTRAINT [PK_Customers] PRIMARY KEY ([CustomerID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Employees] (
        [EmployeeID] int NOT NULL IDENTITY,
        [LastName] nvarchar(20) NOT NULL,
        [FirstName] nvarchar(10) NOT NULL,
        [Title] nvarchar(30) NULL,
        [TitleOfCourtesy] nvarchar(25) NULL,
        [BirthDate] datetime NULL,
        [HireDate] datetime NULL,
        [Address] nvarchar(60) NULL,
        [City] nvarchar(15) NULL,
        [Region] nvarchar(15) NULL,
        [PostalCode] nvarchar(10) NULL,
        [Country] nvarchar(15) NULL,
        [HomePhone] nvarchar(24) NULL,
        [Extension] nvarchar(4) NULL,
        [Photo] image NULL,
        [Notes] ntext NULL,
        [ReportsTo] int NULL,
        [PhotoPath] nvarchar(255) NULL,
        CONSTRAINT [PK_Employees] PRIMARY KEY ([EmployeeID]),
        CONSTRAINT [FK_Employees_Employees] FOREIGN KEY ([ReportsTo]) REFERENCES [Employees] ([EmployeeID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Region] (
        [RegionID] int NOT NULL,
        [RegionDescription] nchar(50) NOT NULL,
        CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED ([RegionID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Shippers] (
        [ShipperID] int NOT NULL IDENTITY,
        [CompanyName] nvarchar(40) NOT NULL,
        [Phone] nvarchar(24) NULL,
        CONSTRAINT [PK_Shippers] PRIMARY KEY ([ShipperID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Suppliers] (
        [SupplierID] int NOT NULL IDENTITY,
        [CompanyName] nvarchar(40) NOT NULL,
        [ContactName] nvarchar(30) NULL,
        [ContactTitle] nvarchar(30) NULL,
        [Address] nvarchar(60) NULL,
        [City] nvarchar(15) NULL,
        [Region] nvarchar(15) NULL,
        [PostalCode] nvarchar(10) NULL,
        [Country] nvarchar(15) NULL,
        [Phone] nvarchar(24) NULL,
        [Fax] nvarchar(24) NULL,
        [HomePage] ntext NULL,
        CONSTRAINT [PK_Suppliers] PRIMARY KEY ([SupplierID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [CustomerCustomerDemo] (
        [CustomerID] nchar(5) NOT NULL,
        [CustomerTypeID] nchar(10) NOT NULL,
        CONSTRAINT [PK_CustomerCustomerDemo] PRIMARY KEY NONCLUSTERED ([CustomerID], [CustomerTypeID]),
        CONSTRAINT [FK_CustomerCustomerDemo] FOREIGN KEY ([CustomerTypeID]) REFERENCES [CustomerDemographics] ([CustomerTypeID]),
        CONSTRAINT [FK_CustomerCustomerDemo_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [Customers] ([CustomerID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Territories] (
        [TerritoryID] nvarchar(20) NOT NULL,
        [TerritoryDescription] nchar(50) NOT NULL,
        [RegionID] int NOT NULL,
        CONSTRAINT [PK_Territories] PRIMARY KEY NONCLUSTERED ([TerritoryID]),
        CONSTRAINT [FK_Territories_Region] FOREIGN KEY ([RegionID]) REFERENCES [Region] ([RegionID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Orders] (
        [OrderID] int NOT NULL IDENTITY,
        [CustomerID] nchar(5) NULL,
        [EmployeeID] int NULL,
        [OrderDate] datetime NULL,
        [RequiredDate] datetime NULL,
        [ShippedDate] datetime NULL,
        [ShipVia] int NULL,
        [Freight] money NULL DEFAULT 0.0,
        [ShipName] nvarchar(40) NULL,
        [ShipAddress] nvarchar(60) NULL,
        [ShipCity] nvarchar(15) NULL,
        [ShipRegion] nvarchar(15) NULL,
        [ShipPostalCode] nvarchar(10) NULL,
        [ShipCountry] nvarchar(15) NULL,
        CONSTRAINT [PK_Orders] PRIMARY KEY ([OrderID]),
        CONSTRAINT [FK_Orders_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [Customers] ([CustomerID]),
        CONSTRAINT [FK_Orders_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [Employees] ([EmployeeID]),
        CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY ([ShipVia]) REFERENCES [Shippers] ([ShipperID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [Products] (
        [ProductID] int NOT NULL IDENTITY,
        [ProductName] nvarchar(40) NOT NULL,
        [SupplierID] int NULL,
        [CategoryID] int NULL,
        [QuantityPerUnit] nvarchar(20) NULL,
        [UnitPrice] money NULL DEFAULT 0.0,
        [UnitsInStock] smallint NULL DEFAULT CAST(0 AS smallint),
        [UnitsOnOrder] smallint NULL DEFAULT CAST(0 AS smallint),
        [ReorderLevel] smallint NULL DEFAULT CAST(0 AS smallint),
        [Discontinued] bit NOT NULL,
        CONSTRAINT [PK_Products] PRIMARY KEY ([ProductID]),
        CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryID]) REFERENCES [Categories] ([CategoryID]),
        CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY ([SupplierID]) REFERENCES [Suppliers] ([SupplierID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [EmployeeTerritories] (
        [EmployeeID] int NOT NULL,
        [TerritoryID] nvarchar(20) NOT NULL,
        CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED ([EmployeeID], [TerritoryID]),
        CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [Employees] ([EmployeeID]),
        CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY ([TerritoryID]) REFERENCES [Territories] ([TerritoryID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE TABLE [OrderDetails] (
        [OrderID] int NOT NULL,
        [ProductID] int NOT NULL,
        [UnitPrice] money NOT NULL,
        [Quantity] smallint NOT NULL DEFAULT CAST(1 AS smallint),
        [Discount] real NOT NULL,
        CONSTRAINT [PK_Order_Details] PRIMARY KEY ([OrderID], [ProductID]),
        CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY ([OrderID]) REFERENCES [Orders] ([OrderID]),
        CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY ([ProductID]) REFERENCES [Products] ([ProductID])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [CategoryName] ON [Categories] ([CategoryName]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [IX_CustomerCustomerDemo_CustomerTypeID] ON [CustomerCustomerDemo] ([CustomerTypeID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [City] ON [Customers] ([City]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [CompanyName] ON [Customers] ([CompanyName]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [PostalCode] ON [Customers] ([PostalCode]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [Region] ON [Customers] ([Region]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [IX_Employees_ReportsTo] ON [Employees] ([ReportsTo]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [LastName] ON [Employees] ([LastName]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [PostalCode] ON [Employees] ([PostalCode]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [IX_EmployeeTerritories_TerritoryID] ON [EmployeeTerritories] ([TerritoryID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [OrderID] ON [OrderDetails] ([OrderID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [OrdersOrder_Details] ON [OrderDetails] ([OrderID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [ProductID] ON [OrderDetails] ([ProductID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [ProductsOrder_Details] ON [OrderDetails] ([ProductID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [CustomerID] ON [Orders] ([CustomerID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [CustomersOrders] ON [Orders] ([CustomerID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [EmployeeID] ON [Orders] ([EmployeeID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [EmployeesOrders] ON [Orders] ([EmployeeID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [OrderDate] ON [Orders] ([OrderDate]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [ShippedDate] ON [Orders] ([ShippedDate]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [ShippersOrders] ON [Orders] ([ShipVia]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [ShipPostalCode] ON [Orders] ([ShipPostalCode]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [CategoriesProducts] ON [Products] ([CategoryID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [CategoryID] ON [Products] ([CategoryID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [ProductName] ON [Products] ([ProductName]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [SupplierID] ON [Products] ([SupplierID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [SuppliersProducts] ON [Products] ([SupplierID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [CompanyName] ON [Suppliers] ([CompanyName]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [PostalCode] ON [Suppliers] ([PostalCode]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    CREATE INDEX [IX_Territories_RegionID] ON [Territories] ([RegionID]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705104820_InitialMigration'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240705104820_InitialMigration', N'8.0.4');
END;
GO

COMMIT;
GO


BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705125413_TASK-0001_AddPhotoBase64ColumnToEmployeeTable'
)
BEGIN
    ALTER TABLE [Employees] ADD [PhotoBase64] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240705125413_TASK-0001_AddPhotoBase64ColumnToEmployeeTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240705125413_TASK-0001_AddPhotoBase64ColumnToEmployeeTable', N'8.0.4');
END;
GO

COMMIT;
GO


CREATE PROCEDURE ObtenerProductosConStockBajo
    @limiteStock INT
AS
BEGIN
    SELECT * FROM Productos WHERE Stock < @limiteStock
END

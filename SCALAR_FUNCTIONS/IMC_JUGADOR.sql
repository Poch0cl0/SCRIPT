CREATE FUNCTION dbo.fn_CalcularIMC
(
    @Peso FLOAT,        
    @Altura FLOAT      
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @IMC FLOAT;

    IF @Altura = 0
    BEGIN
        RETURN NULL;
    END

    SET @IMC = @Peso / (@Altura * @Altura);

    RETURN @IMC;
END
GO